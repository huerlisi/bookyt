class Bank < Person
  # Access restrictions
  attr_accessible :swift, :clearing

  has_many :bank_accounts

  def to_s
    return "" unless vcard

    [vcard.full_name, vcard.locality].compact.join(', ')
  end
end
