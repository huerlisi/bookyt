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

  # Validations
  validates_date :due_date, :value_date
  validates_presence_of :customer, :company, :title, :state

  # String
  def to_s(format = :default)
    return "" if amount.nil?

    identifier = title
    identifier += " / #{code}" if code.present?

    case format
      when :reference
        return identifier + " (#{customer.to_s})"
      when :long
        return "%s: %s für %s à %s"  % [I18n::localize(value_date), identifier, customer, currency_fmt(amount)]
      else
        return identifier
    end
  end

  # Copying
  # =======
  def copy
    dup
  end

  # Search
  # ======
  scope :by_text, lambda {|value|
    text   = '%' + value + '%'

    amount = value.delete("'").to_f
    if amount == 0.0
      amount = nil unless value.match(/^[0.]*$/)
    end

    date   = nil
    begin
      date = Date.parse(value)
    rescue ArgumentError
    end

    people = Person.by_name(value)

    where("title LIKE :text OR code LIKE :text OR remarks LIKE :text OR amount = :amount OR date(value_date) = :date OR date(due_date) = :date OR company_id IN (:people) OR customer_id IN (:people)", :text => text, :amount => amount, :date => date, :people => people)
  }

  # Attachments
  # ===========
  has_many :attachments, :as => :object
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

  def direct_account_factor
    direct_account.is_asset_account? ? 1 : -1
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
    value = line_items.non_saldo_items.to_a.sum(&:accounted_amount)

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
    self.amount = self.balance
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

  # bookyt_stock
  # ============
  include BookytStock::Invoice

  # Sphinx Search
  # =============
  define_index do
    # Delta index
    set_property :delta => true

    indexes state, :as => :invoice_state

    indexes code
    indexes title
    indexes remarks
    indexes value_date, :sortable => true
    indexes due_date, :sortable => true
    indexes text

    indexes customer.vcards.full_name
    indexes customer.vcards.nickname
    indexes customer.vcards.family_name
    indexes customer.vcards.given_name
    indexes customer.vcards.additional_name

    indexes company.vcards.full_name
    indexes company.vcards.nickname
    indexes company.vcards.family_name
    indexes company.vcards.given_name
    indexes company.vcards.additional_name
  end
end
