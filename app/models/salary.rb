class Salary < Invoice
  def net_amount
    salary_invoice_booking = bookings.where(:debit_account_id => Account.find_by_code('2050').id).first
    return 0.0 unless salary_invoice_booking

    salary_invoice_booking.amount
  end
  
  # Bookings
  def self.direct_account
    Account.find_by_code("2050")
  end
end
