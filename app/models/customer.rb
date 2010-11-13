class Customer < Person
  # Associations
  has_many :invoices
end
