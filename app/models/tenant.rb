class Tenant < ActiveRecord::Base
  # Associations
  belongs_to :company, :foreign_key => :person_id
  accepts_nested_attributes_for :company
  has_many :users

  # Validations
  validates_presence_of :company
end
