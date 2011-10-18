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

  # Callback hook
  def booking_saved(booking)
    if (self.state != 'canceled') and (self.state != 'reactivated') and (self.amount <= 0.0)
      update_attribute(:state, 'paid')
    elsif !self.overdue? and (self.amount > 0.0)
      update_attribute(:state, 'booked')
    end
  end
end
