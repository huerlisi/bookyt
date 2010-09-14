class Person < ActiveRecord::Base
  has_many :vcards, :as => :object
  has_one :vcard, :as => :object

  accepts_nested_attributes_for :vcard
end
