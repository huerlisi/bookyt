class Customer < Person
  # Helpers
  def to_s
    "%s (%s)" % [vcard.try(:full_name), vcard.try(:locality)]
  end
end
