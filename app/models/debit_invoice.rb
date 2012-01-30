class DebitInvoice < Invoice
  # Accounts
  # ========
  def self.direct_account
    Account.find_by_code("1100")
  end

  def self.available_credit_accounts
    Account.by_type('current_assets')
  end

  def self.default_credit_account
    self.direct_account
  end

  def self.available_debit_accounts
    Account.by_type(['earnings', 'outside_capital'])
  end

  def self.default_debit_account
    Account.find_by_code('3200')
  end

  def balance_account
    bookings.first.try(:credit_account)
  end

  def profit_account
    bookings.first.try(:debit_account)
  end

  # Code
  after_save :update_code
  def update_code
    code = value_date.strftime("%y%m")
    code += "%04i" % id

    update_column(:code, code)
  end
end
