class Employee < Person
  # Associations
  has_many :employments
  has_many :employers, :through => :employments

  # Constructor
  def initialize(attributes = nil)
    super

    build_vcard unless vcard
  end

  # Helpers
  def to_s
    "%s (%s)" % [vcard.try(:full_name), date_of_birth]
  end
end
