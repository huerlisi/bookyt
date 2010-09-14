class Employer < Person
  # Associations
  has_many :employments
  has_many :employees, :through => :employments
end
