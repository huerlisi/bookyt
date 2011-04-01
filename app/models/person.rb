class Person < ActiveRecord::Base
  # sex enumeration
  MALE   = 1
  FEMALE = 2

  # Associations
  has_many :vcards, :as => :object
  has_one :vcard, :as => :object

  accepts_nested_attributes_for :vcard

  # Validations
  validates_date :date_of_birth, :date_of_death, :allow_nil => true, :allow_blank => true
  validates_presence_of :vcard

  # Invoices
  has_many :credit_invoices, :foreign_key => :customer_id
  has_many :debit_invoices, :foreign_key => :company_id

  # Constructor
  def initialize(attributes = nil)
    super

    build_vcard unless vcard
    vcard.build_address unless vcard.address
  end

  # Search
  scope :by_name, lambda {|value|
    includes(:vcard).where("(vcards.given_name LIKE :query) OR (vcards.family_name LIKE :query) OR (vcards.full_name LIKE :query)", :query => "%#{value}%")
  }

  # Helpers
  def to_s
    return unless vcard
    
    s = vcard.full_name
    s += " (#{vcard.locality})" if vcard.locality
    
    return s
  end
end
