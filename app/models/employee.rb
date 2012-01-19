class Employee < Person
  # Associations
  has_many :salaries, :foreign_key => :company_id

  # Charge Rates
  has_many :charge_rates, :foreign_key => :person_id

  # Employments
  has_many :employments, :inverse_of => :employee
  accepts_nested_attributes_for :employments
  has_many :employers, :through => :employments

  # bookyt_salary
  include BookytSalary::Employee
end
