class Person < ActiveRecord::Base
  # Validations
  validates_date :date_of_birth, :date_of_death, :allow_nil => true, :allow_blank => true
  validates_presence_of :vcard

  # sex enumeration
  MALE   = 1
  FEMALE = 2
  def sex_to_s(format = :default)
    case sex
    when MALE
      "M"
    when FEMALE
      "F"
    end
  end

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
  has_many :vcards, :as => :object, :class_name => 'HasVcards::Vcard'
  has_one :vcard, :as => :object, :class_name => 'HasVcards::Vcard'
  accepts_nested_attributes_for :vcard

  # Search
  include PgSearch
  #default_scope includes(:vcard).order("COALESCE(vcards.full_name, CONCAT(vcards.family_name, ' ', vcards.given_name))")
  pg_search_scope :by_text, :associated_against => { :vcards => [:full_name, :family_name, :given_name] }, :using => {:tsearch => {:prefix => true}}

  scope :by_name, lambda {|value|
    includes(:vcard).where("(vcards.given_name LIKE :query) OR (vcards.family_name LIKE :query) OR (vcards.full_name LIKE :query)", :query => "%#{value}%")
  }

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

  def invoices
    Invoice.order('value_date DESC').where("invoices.customer_id = :id OR invoices.company_id = :id", :id => self.id)
  end

  # Charge Rates
  # ============
  has_many :charge_rates

  # Attachments
  # ===========
  has_many :attachments, :as => :object
  accepts_nested_attributes_for :attachments, :reject_if => proc { |attributes| attributes['file'].blank? }

  # Others
  # ======
  belongs_to :civil_status
  belongs_to :religion

  # bookyt_projects
  # ===============
  include BookytProjects::Person
end
