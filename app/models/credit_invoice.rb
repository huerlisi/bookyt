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
        return "%s: %s von %s à %s"  % [I18n::localize(value_date), identifier, company, currency_fmt(amount)]
      else
        return identifier
    end
  end

  # Accounts
  # ========
  def self.profit_account
    Account.tagged_with('invoice:costs').first
  end

  def self.balance_account
    Account.tagged_with('invoice:credit').first
  end

  def self.available_credit_accounts
    Account.by_type(['costs', 'current_assets', 'capital_assets'])
  end

  def self.available_debit_accounts
    Account.by_type(['outside_capital'])
  end

  def self.debit_account
    profit_account
  end

  def self.credit_account
    balance_account
  end
end
