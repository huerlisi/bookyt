class Company < Person
  # Associations
  has_many :employments, :foreign_key => :employer_id
  has_many :employees, :through => :employments
end
