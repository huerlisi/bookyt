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
  # We pass the value_date to the booking
  def update_bookings
    # Start fresh
    # TODO: works badly if validation fails
    bookings.destroy_all

    # Build a booking per line item
    line_items(true).each do |line_item|
      # Build and assign booking
      booking = bookings.create(
        :title          => line_item.title,
        :amount         => line_item.total_amount.currency_round,
        :value_date     => self.value_date,
        :credit_account => direct_account,
        :debit_account  => line_item.contra_account
      )
    end
  end

  # Callback hook
  def booking_saved(booking)
    if (self.state != 'canceled') and (self.state != 'reactivated') and (self.amount <= 0.0)
      update_attribute(:state, 'paid')
    elsif !self.overdue? and (self.amount > 0.0)
      update_attribute(:state, 'booked')
    end
  end
end
