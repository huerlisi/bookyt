class Tenant < ActiveRecord::Base
  # Associations
  belongs_to :company, :foreign_key => :person_id
  has_many :users

  # Validations
  validates_presence_of :company
end
