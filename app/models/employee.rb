class Employee < Person
  # Associations
  has_many :employments
  has_many :employers, :through => :employments
  has_many :salaries, :foreign_key => :company_id
end
