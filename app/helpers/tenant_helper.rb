module TenantHelper
  def total_over_range(accounts, range)
    accounts_saldo = accounts.inject(BigDecimal.new('0')) do |sum, account|
      sum + account.saldo(range)
    end
  end
end
