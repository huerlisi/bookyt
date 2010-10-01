class Company < Person
  # Associations
  has_many :employments, :foreign_key => :employer_id
  has_many :employees, :through => :employments

  # Helpers
  def to_s
    "%s (%s)" % [vcard.try(:full_name), vcard.try(:locality)]
  end
end
