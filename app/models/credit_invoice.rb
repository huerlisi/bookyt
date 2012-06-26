# encoding: utf-8

class CreditInvoice < Invoice
  # String
  def to_s(format = :default)
    return "" if amount.nil?

    identifier = title
    identifier += " / #{code}" if code.present?

    case format
      when :reference
        return identifier + " (#{company.to_s})"
      when :long
        return "%s: %s für %s à %s"  % [I18n::localize(value_date), ident, company, currency_fmt(amount)]
      else
        return identifier
    end
  end

  # Accounts
  # ========
  def self.direct_account
    Account.find_by_code("2000")
  end

  def self.available_credit_accounts
    Account.by_type(['costs', 'current_assets', 'capital_assets'])
  end

  def self.default_credit_account
    Account.find_by_code('4000')
  end

  def self.available_debit_accounts
    Account.by_type(['outside_capital'])
  end

  def self.default_debit_account
    self.direct_account
  end

  def balance_account
    bookings.first.try(:debit_account)
  end

  def profit_account
    bookings.first.try(:credit_account)
  end
end
