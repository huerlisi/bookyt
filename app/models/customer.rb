class Customer < Person
  # Associations
  has_many :invoices
  
  # Helpers
  def to_s
    "%s (%s)" % [vcard.try(:full_name), vcard.try(:locality)]
  end
end
