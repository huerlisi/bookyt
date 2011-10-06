class Invoice < ActiveRecord::Base
  # Aspects
  include ApplicationHelper

  # Scopes
  default_scope order(:due_date)
  scope :overdue, where("due_date < NOW()")

  # Associations
  belongs_to :customer, :class_name => 'Person'
  belongs_to :company, :class_name => 'Person'

  # Validations
  validates_date :due_date, :value_date
  validates_presence_of :customer, :company, :title, :amount, :state

  # String
  def to_s(format = :default)
    return "" if amount.nil?

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
  STATES = ['booked', 'canceled', 'paid']
  scope :by_state, lambda {|value|
    where(:state => value) unless value == 'all'
  }

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

  # Line Items
  # ==========
  has_many :line_items, :autosave => true
  accepts_nested_attributes_for :line_items, :allow_destroy => true, :reject_if => proc { |attributes| attributes['quantity'].blank? or attributes['quantity'] == '0' }

  def amount
    self[:amount] || line_items.sum('times * price').to_f
  end

  def esr9(bank_account)
    esr9_build(amount, id, bank_account.pc_id, bank_account.esr_id)
  end

  private
  # ESR helpers
  def esr9_build(esr_amount, id, biller_id, esr_id)
    # 01 is type 'Einzahlung in CHF'
    amount_string = "01#{sprintf('%011.2f', esr_amount).delete('.')}"
    id_string = esr_number(esr_id, customer.id)
    biller_string = esr9_format_account_id(biller_id)

    "#{esr9_add_validation_digit(amount_string)}>#{esr9_add_validation_digit(id_string)}+ #{biller_string}>"
  end

  def esr_number(esr_id, patient_id)
    esr_id.to_s + sprintf('%013i', patient_id).delete(' ') + sprintf('%07i', id).delete(' ')
  end

  def esr9_add_validation_digit(value)
    # Defined at http://www.pruefziffernberechnung.de/E/Einzahlungsschein-CH.shtml
    esr9_table = [0, 9, 4, 6, 8, 2, 7, 1, 3, 5]
    digit = 0
    value.split('').map{|c| digit = esr9_table[(digit + c.to_i) % 10]}
    digit = (10 - digit) % 10

    "#{value}#{digit}"
  end

  def esr9_format(reference_code)
    # Drop all leading zeroes
    reference_code.gsub!(/^0*/, '')

    # Group by 5 digit blocks, beginning at the right side
    reference_code.reverse.gsub(/(.....)/, '\1 ').reverse
  end

  def esr9_format_account_id(account_id)
    (pre, main, post) = account_id.split('-')

    sprintf('%02i%06i%1i', pre, main, post)
  end
end
