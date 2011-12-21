class Invoice < ActiveRecord::Base
  # Aspects
  include ApplicationHelper

  # Scopes
  default_scope order("due_date DESC")

  # Associations
  belongs_to :customer, :class_name => 'Person'
  belongs_to :company, :class_name => 'Person'

  # Validations
  validates_date :due_date, :value_date
  validates_presence_of :customer, :company, :title, :state

  # String
  def to_s(format = :default)
    return "" if amount == 0.0

    identifier = title
    identifier += " / #{code}" if code.present?

    case format
      when :reference
        return identifier + " (#{customer.to_s})"
      when :long
        return "%s: %s für %s à %s"  % [I18n::localize(value_date), ident, customer, currency_fmt(amount)]
      else
        return identifier
    end
  end

  before_save :update_code
  def update_code
    code = value_date.strftime("%y%m")
    code += "%04i" % id

    self.code = code
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
  scope :by_state, lambda {|value|
    where(:state => value) unless value == 'all'
  }

  scope :prepared, :conditions => "state = 'prepared'"
  scope :canceled, :conditions => "state = 'canceled'"
  scope :reactivated, :conditions => "state = 'reactivated'"
  scope :active, :conditions => "NOT(state IN ('reactivated', 'canceled'))"
  scope :open, :conditions => "NOT(state IN ('reactivated', 'canceled', 'paid'))"
  scope :overdue, :conditions => ["(state = 'booked' AND due_date < :today) OR (state = 'reminded' AND reminder_due_date < :today) OR (state = '2xreminded' AND second_reminder_due_date < :today)", {:today => Date.today}]
  scope :in_encashment, :conditions => ["state = 'encashment'"]

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

  # Period
  # ======
  scope :active_at, lambda {|value| Invoice.where("date(duration_from) < :date AND date(duration_to) > :date", :date => value)}

  # Bookings
  # ========
  include HasAccounts::Model

  # Build booking
  #
  # We pass the value_date to the booking
  def build_booking(params = {}, template_code = nil)
    invoice_params = {:value_date => self.value_date}
    template_code ||= self.class.to_s.underscore + ':invoice'

    invoice_params.merge!(params)

    super(invoice_params, template_code)
  end

  # Callback hook
  def booking_saved(booking)

    if (self.state != 'canceled') and (self.state != 'reactivated') and (self.balance <= 0.0)
      new_state = 'paid'
    elsif !self.overdue? and (self.balance > 0.0)
      new_state = 'booked'
    end

    self.state = new_state
    self.update_column(:state, new_state) if self.persisted?
  end

  # Line Items
  # ==========
  has_many :line_items, :autosave => true, :inverse_of => :invoice
  accepts_nested_attributes_for :line_items, :allow_destroy => true, :reject_if => proc { |attributes| attributes['quantity'].blank? or attributes['quantity'] == '0' }

  def amount
    if line_items.empty?
      value = self[:amount]
    else
      value = line_items.to_a.sum(&:total_amount)
    end

    if value
      return value.currency_round
    else
      return 0.0
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

  # Sphinx Search
  define_index do
    # Delta index
    set_property :delta => true

    indexes state, :as => :by_state

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
