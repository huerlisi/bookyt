class DebitInvoice < Invoice
  # Accounts
  # ========
  def self.direct_account
    Account.find_by_code("1100")
  end

  def self.available_contra_accounts
    Account.by_type(['earnings', 'outside_capital'])
  end

  def self.default_contra_account
    Account.find_by_code('3200')
  end

  def balance_account
    bookings.first.try(:credit_account)
  end

  def profit_account
    bookings.first.try(:debit_account)
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
        :amount         => line_item.total_amount.currency_round,
        :value_date     => self.value_date,
        :credit_account => direct_account,
        :debit_account  => line_item.contra_account
      )
    end
  end
end
