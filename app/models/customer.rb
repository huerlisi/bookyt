class Customer < Person
  # Associations
  has_many :invoices, :order => 'value_date DESC'
end
