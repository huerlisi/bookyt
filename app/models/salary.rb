class Salary < Invoice
  # String
  def to_s(format = :default)
    "%s (%s / %s - %s)" % [title, company, duration_from ? I18n::localize(duration_from) : '', duration_to ? I18n::localize(duration_to) : '']
  end

  # Calculations
  def net_amount
    salary_invoice_booking = bookings.where(:debit_account_id => Account.find_by_code('2050').id).first
    return 0.0 unless salary_invoice_booking

    salary_invoice_booking.amount
  end

  def bvg_amount
    bookings.by_text("BVG").sum(:amount)
  end

  def social_amount
    result = bookings.by_text("AHV/IV/EO Arbeitnehmer").sum(:amount)
    result += bookings.by_text("ALV Arbeitnehmer").sum(:amount)
    result += bookings.by_text("NBU Arbeitnehmer").sum(:amount)

    result
  end

  def ahv_amount
    result = amount
    result += bookings.where(:title => "Kinderzulage").sum(:amount)

    result
  end

  # Assignment proxies
  def duration_from=(value)
    write_attribute(:duration_from, value)

    value_as_date = self.duration_from
    # Calculate value and due dates
    date = Date.new(value_as_date.year, value_as_date.month, 1).in(1.month).ago(1.day)
    self.value_date ||= date
    self.due_date   ||= date
  end

  # Filter/Search
  # =============
  scope :by_value_period, lambda {|from, to| where("date(value_date) BETWEEN ? AND ?", from, to) }
  scope :by_employee_id, lambda {|value| where(:company_id => value)}

  # Bookings
  # ========
  def self.direct_account
    Account.find_by_code("5000")
  end

  # Build booking
  #
  # We need to ensure the order of creation as we depent on current balance.
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

    super(params, 'salary:employee:ktg').save
    super(params.merge(:person_id => company.id), "salary:bvg").save

    super(params, 'salary:invoice').save

    super(params.merge(:person_id => company.id), "salary:kz").save
    super(params.merge(:person_id => company.id), "salary:social:kz").save
  end
end
