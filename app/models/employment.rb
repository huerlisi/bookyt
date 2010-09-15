class Employment < ActiveRecord::Base
  # Associations
  belongs_to :employee
  belongs_to :employer
  
  # Validations
  validates_presence_of :employee, :employer
  validates_date :duration_from, :duration_to, :allow_nil => true, :allow_blank => true
end
