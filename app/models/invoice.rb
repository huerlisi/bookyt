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
    identifier += " (#{code})" if code
    
    case format
      when :long
        return "%s: %s für %s à %s"  % [I18n::localize(value_date), ident, customer, currency_fmt(amount)]
      else
        return identifier
    end
  end

  # Attachments
  # ===========
  has_many :attachments, :as => :object
  accepts_nested_attributes_for :attachments
  
  # States
  # ======
  STATES = ['booked', 'canceled', 'paid']
  scope :by_state, lambda {|value| where(:state => value)}
  
  # Bookings
  # ========
  include HasAccounts::Model
  
  # Assets
  # ======
  has_many :assets, :foreign_key => :purchase_invoice_id
end
