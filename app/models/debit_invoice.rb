class DebitInvoice < Invoice
  # Bookings
  def self.direct_account
    Account.find_by_code("1100")
  end
end
