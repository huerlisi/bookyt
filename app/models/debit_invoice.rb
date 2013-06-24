# encoding: utf-8

class DebitInvoice < Invoice
  # Accounts
  # ========
  def self.profit_account
    Account.tagged_with('invoice:earnings').first
  end

  def self.balance_account
    Account.tagged_with('invoice:debit').first
  end

  def self.available_credit_accounts
    Account.by_type('current_assets')
  end

  def self.available_debit_accounts
    Account.by_type(['earnings', 'outside_capital'])
  end

  def self.credit_account
    balance_account
  end

  def self.debit_account
    profit_account
  end

  # Code
  after_save :update_code
  def update_code
    # Only set calculated code if not set, yet
    return unless code.blank?

    code = value_date.strftime("%y%m")
    code += "%04i" % id

    update_column(:code, code)
  end
end
