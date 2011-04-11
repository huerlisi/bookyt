class CreditInvoice < Invoice
  # String
  def to_s
    return "" if amount.nil?

    "%s (%s) à %s"  % [title, company, currency_fmt(amount)]
  end

  # Bookings
  def self.direct_account
    Account.find_by_code("2000")
  end
end
