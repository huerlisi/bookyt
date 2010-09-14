class Employment < ActiveRecord::Base
  # Associations
  belongs_to :employee
  belongs_to :employer
  
  # Validations
  validates_presence_of :employee, :employer
end
