class CreditInvoice < Invoice
  # String
  def to_s(format = :default)
    return "" if amount.nil?

    identifier = title
    identifier += " (#{code})" if code
    
    case format
      when :long
        return "%s: %s für %s à %s"  % [I18n::localize(value_date), ident, company, currency_fmt(amount)]
      else
        return identifier
    end
  end

  # Bookings
  def self.direct_account
    Account.find_by_code("2000")
  end

  # Accounts
  # ========
  def balance_account
    bookings.first.debit_account
  end
  
  def profit_account
    bookings.first.credit_account
  end
end
