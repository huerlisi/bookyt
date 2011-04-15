class Salary < Invoice
  # Calculations
  def net_amount
    salary_invoice_booking = bookings.where(:debit_account_id => Account.find_by_code('2050').id).first
    return 0.0 unless salary_invoice_booking

    salary_invoice_booking.amount
  end
  
  # Bookings
  # ========
  def self.direct_account
    Account.find_by_code("5000")
  end

  # Build booking
  #
  # We use the value_date of the purchase invoice but our own amount.
  def build_booking(params = {}, template_code = nil)
    # Build and assign booking
    super(params, 'salary:employee:ahv_iv_eo').save
    super(params, 'salary:employer:ahv_iv_eo').save
    super(params, 'salary:employee:alv').save
    super(params, 'salary:employer:alv').save
    super(params, 'salary:employee:nbu').save
    super(params, 'salary:employer:nbu').save
    super(params, 'salary:employer:bu').save
    super(params, 'salary:employer:fak').save
    super(params, 'salary:employer:vkb').save
    
    super(params, 'salary:invoice').save
  end
end
