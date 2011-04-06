class Salary < Invoice
  # Bookings
  def self.direct_account
    Account.find_by_code("2050")
  end
end
