# encoding: utf-8

class Invoice < ActiveRecord::Base
  # Aspects
  include ApplicationHelper

  # Scopes
  default_scope order("due_date DESC")

  # Associations
  belongs_to :customer, :class_name => 'Person'
  accepts_nested_attributes_for :customer
  belongs_to :company, :class_name => 'Person'
  accepts_nested_attributes_for :company
  has_many :vcards, :through => :customer

  # Validations
  validates_date :due_date, :value_date
  validates_presence_of :customer, :company, :title, :state

  # String
  def to_s(format = :default)
    return "" if amount.nil?

    identifier = title

    case format
      when :reference
        return identifier + " (#{customer.to_s})"
      when :long
        return "%s: %s für %s à %s"  % [I18n::localize(value_date), identifier, customer, currency_fmt(amount)]
      else
        return identifier
    end
  end

  # Ident
  # =====
  def ident
    date_ident = updated_at.strftime("%y%m")
    date_ident += "%03i" % id

    date_ident
  end

  def long_ident
    "#{ident} - #{customer.vcard.full_name} #{title}"
  end

  # Copying
  # =======
  def copy(payment_period)
    new_invoice = dup

    # Rebuild positions
    new_invoice.line_items = line_items.map{ |line_item| line_item.copy }

    new_invoice.duration_from = duration_to.tomorrow if duration_to
    if duration_to && duration_from
      if duration_from == duration_from.beginning_of_month && duration_to == duration_to.end_of_month
        months = duration_to.month - duration_from.month
        duration = (months + 1).months - 1.days
      else
        duration = duration_to.to_time - duration_from.to_time - 1.days
      end

      new_invoice.duration_to = new_invoice.duration_from.in(duration).to_date
    end

    # Override some fields
    new_invoice.attributes = {
      :state         => 'booked',
      :value_date    => Date.today,
      :due_date      => Date.today.in(payment_period).to_date,
    }

    new_invoice
  end

  # Search
  # ======
  include PgSearch
  pg_search_scope :by_text, :against => [:code, :title, :remarks, :text], :associated_against => { :vcards => [:full_name, :family_name, :given_name] }, :using => {:tsearch => {:prefix => true}}

  # Attachments
  # ===========
  has_many :attachments, :as => :reference
  accepts_nested_attributes_for :attachments, :reject_if => proc { |attributes| attributes['file'].blank? }

  # States
  # ======
  STATES = ['booked', 'canceled', 'paid', 'reactivated', 'reminded', '2xreminded', '3xreminded', 'encashment', 'written_off']
  scope :invoice_state, lambda {|value|
    where(:state => value) unless (value.nil? or value == 'all')
  }

  scope :prepared, :conditions => "state = 'prepared'"
  scope :canceled, :conditions => "state = 'canceled'"
  scope :reactivated, :conditions => "state = 'reactivated'"
  scope :active, :conditions => "NOT(state IN ('reactivated', 'canceled'))"
  scope :open, :conditions => "NOT(state IN ('reactivated', 'canceled', 'paid'))"
  scope :overdue, :conditions => ["(state = 'booked' AND due_date < :today) OR (state = 'reminded' AND reminder_due_date < :today) OR (state = '2xreminded' AND second_reminder_due_date < :today)", {:today => Date.today}]
  scope :in_encashment, :conditions => ["state = 'encashment'"]
  scope :open_balance, where("due_amount != 0")

  def active
    !(state == 'canceled' or state == 'reactivated' or state == 'written_off')
  end

  def open
    active and !(state == 'paid')
  end

  def state_adverb
    I18n.t state, :scope => 'invoice.state'
  end

  def state_noun
    I18n.t state, :scope => 'invoice.state_noun'
  end

  def overdue?
    return true if state == 'booked' and due_date < Date.today
    return true if state == 'reminded' and (reminder_due_date.nil? or reminder_due_date < Date.today)
    return true if state == '2xreminded' and (second_reminder_due_date.nil? or second_reminder_due_date < Date.today)
    return true if state == '3xreminded' and (third_reminder_due_date.nil? or third_reminder_due_date < Date.today)

    return false
  end

  include Invoice::Actions

  # Period
  # ======
  scope :active_at, lambda {|value| Invoice.where("date(duration_from) < :date AND date(duration_to) > :date", :date => value)}

  # Bookings
  # ========
  include HasAccounts::Model

  # Callback hook
  def calculate_state

    if (self.state != 'canceled') and (self.state != 'reactivated') and (self.balance <= 0.0)
      new_state = 'paid'
    elsif !self.overdue? and (self.balance > 0.0)
      new_state = 'booked'
    end

    # Guard as we don't only set new_state if some conditions match
    return unless new_state

    self.state = new_state
  end

  accepts_nested_attributes_for :bookings, :allow_destroy => true

  def self.direct_account
    balance_account
  end

  def self.balance_account
    nil # will be overloaded by subclass
  end

  def balance_account
    self.class.balance_account
  end

  def profit_account
    self.class.profit_account
  end

  def write_off_account
    self.class.write_off_account
  end

  def direct_account_factor
    # Guard
    return 1 unless direct_account

    direct_account.asset_account? ? 1 : -1
  end

  # Line Items
  # ==========
  has_many :line_items, :autosave => true, :inverse_of => :invoice, :dependent => :destroy
  accepts_nested_attributes_for :line_items, :allow_destroy => true, :reject_if => proc { |attributes| attributes['quantity'].blank? or attributes['quantity'] == '0' }

  # Amount caching
  # ==============
  before_save :calculate_amount
  def calculate_amount
    # Need to use to_a as not all line items are persisted for sure
    value = line_items.to_a.sum(&:accounted_amount)

    if value
      self.amount = value.currency_round
    else
      self.amount = 0.0
    end
  end

  # Handle touching by line_items
  after_touch :update_amount
  def update_amount
    update_column(:amount, calculate_amount)
  end

  before_save :calculate_due_amount
  def calculate_due_amount
    self.due_amount = self.balance
  end

  # Handle touching by line_items
  after_touch :update_due_amount
  def update_due_amount
    update_column(:due_amount, calculate_due_amount)
  end

  def amount_of(code)
   # Can't use arel as not all line items are persisted for sure
   if line_item = line_items.select{|item| item.code == code}.first
      # Return the total_amount
      return line_item.accounted_amount
    else
      # Sum over items to be included by tag
      included = line_items.select{|item| item.include_in_saldo_list.include?(code) }
      return included.sum(&:accounted_amount)
    end

    return 0.0 unless line_item

    line_item.accounted_amount
  end

  # bookyt_stock
  # ============
  include BookytStock::Invoice

  # Webhooks
  # ========
  after_update :call_webhooks
  def call_webhooks
    return unless state_was.to_s != 'paid'
    return unless state.to_s == 'paid'
    Webhook.call(self, :paid)
  end
end
