class Employee < Person
  # Associations
  has_many :salaries, :foreign_key => :company_id

  # Charge Rates
  has_many :charge_rates, :foreign_key => :person_id

  # Employments
  has_many :employments
  has_many :employers, :through => :employments
end
