class Person < ActiveRecord::Base
  # Validations
  validates_date :date_of_birth, :date_of_death, :allow_nil => true, :allow_blank => true
  validates_presence_of :vcard

  # sex enumeration
  MALE   = 1
  FEMALE = 2

  # String
  def to_s(format = :default)
    return unless vcard

    s = vcard.full_name

    case format
      when :long
        s += " (#{vcard.locality})" if vcard.locality
    end

    return s
  end

  # VCards
  # ======
  has_many :vcards, :as => :object
  has_one :vcard, :as => :object
  accepts_nested_attributes_for :vcard

  # Search
  default_scope includes(:vcard).order('IFNULL(vcards.full_name, vcards.family_name + ' ' + vcards.given_name)')

  scope :by_name, lambda {|value|
    includes(:vcard).where("(vcards.given_name LIKE :query) OR (vcards.family_name LIKE :query) OR (vcards.full_name LIKE :query)", :query => "%#{value}%")
  }

  define_index do
    indexes social_security_nr
    indexes social_security_nr_12
    indexes date_of_birth
    indexes date_of_death

    indexes vcards.full_name
    indexes vcards.nickname
    indexes vcards.family_name
    indexes vcards.given_name
    indexes vcards.additional_name
  end

  # Constructor
  def initialize(attributes = nil, options = {})
    super

    build_vcard unless vcard
    vcard.build_address unless vcard.address
  end

  # Invoices
  # ========
  has_many :credit_invoices, :class_name => 'Invoice', :foreign_key => :customer_id, :order => 'value_date DESC'
  has_many :debit_invoices, :class_name => 'Invoice', :foreign_key => :company_id, :order => 'value_date DESC'

  # Charge Rates
  # ============
  has_many :charge_rates

  # Attachments
  # ===========
  has_many :attachments, :as => :object
  accepts_nested_attributes_for :attachments, :reject_if => proc { |attributes| attributes['file'].blank? }

  # Others
  # ===========
  belongs_to :civil_status
  belongs_to :religion
  has_many :notes, :as => :note_of_sth

end
