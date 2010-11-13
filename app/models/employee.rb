class Employee < Person
  # Associations
  has_many :employments
  has_many :employers, :through => :employments
end
