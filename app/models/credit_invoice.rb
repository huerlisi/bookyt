class CreditInvoice < Invoice
  # String
  def to_s(format = :default)
    return "" if amount == 0.0

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

  def self.available_contra_accounts
    Account.by_type(['costs', 'current_assets', 'capital_assets'])
  end

  def self.default_contra_account
    Account.find_by_code('4000')
  end

  def balance_account
    bookings.first.try(:debit_account)
  end

  def profit_account
    bookings.first.try(:credit_account)
  end

  # Bookings
  # ========
  # We pass the value_date to the booking
  def build_booking(params = {}, template_code = nil)
    for line_item in line_items
      # Build and assign booking
      booking = bookings.build(
        :title          => line_item.title,
        :amount         => line_item.total_amount,
        :value_date     => self.value_date,
        :credit_account => direct_account,
        :debit_account  => line_item.contra_account
      )
    end
  end
end
