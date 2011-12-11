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
  before_save :update_bookings
  accepts_nested_attributes_for :bookings, :allow_destroy => true

  def update_bookings
    return unless changed_for_autosave?

    # Get rid of line_items to be destroyed by nested attributes assignment
    new_line_items = line_items.reject{|line_item| line_item.marked_for_destruction?}

    # Delete all current bookings
    # We need to use mark_for_destruction for two reasons:
    # 1. Don't delete before record is validated and saved
    # 2. Don't trigger callbacks from bookings
    bookings.map{|b| b.mark_for_destruction}

    # Build a booking per line item
    new_line_items.each do |line_item|
      # Build and assign booking
      bookings.build(
        :title          => line_item.title,
        :amount         => line_item.total_amount,
        :value_date     => self.value_date,
        :debit_account  => direct_account,
        :credit_account => line_item.contra_account
      )
    end
  end
end
