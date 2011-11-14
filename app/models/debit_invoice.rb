class DebitInvoice < Invoice
  # Accounts
  # ========
  def self.direct_account
    Account.find_by_code("1100")
  end

  def balance_account
    bookings.first.try(:credit_account)
  end

  def profit_account
    bookings.first.try(:debit_account)
  end

  # Bookings
  # ========

  # Callback hook
  def booking_saved(booking)
    if (self.state != 'canceled') and (self.state != 'reactivated') and (self.amount <= 0.0)
      update_attribute(:state, 'paid')
    elsif !self.overdue? and (self.amount > 0.0)
      update_attribute(:state, 'booked')
    end
  end

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
