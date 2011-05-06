class Invoice < ActiveRecord::Base
  # Aspects
  include ApplicationHelper
  
  # Scopes
  default_scope order(:due_date)
  
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
  
  # Assets
  # ======
  has_many :assets, :foreign_key => :purchase_invoice_id
end
