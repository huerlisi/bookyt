class Person < ActiveRecord::Base
  # Associations
  has_many :vcards, :as => :object
  has_one :vcard, :as => :object

  accepts_nested_attributes_for :vcard

  # Validations
  validates_date :date_of_birth, :date_of_death, :allow_nil => true, :allow_blank => true

  # Constructor
  def initialize(attributes = nil)
    super

    build_vcard unless vcard
    vcard.build_address unless vcard.address
  end
end
