module Invoice::Actions
  # Actions
  def reactivate(comments = nil)
    unless state == 'canceled'
      # Cancel original amount
      bookings.build(:title => "Storno",
                     :comments => comments || "Reaktiviert",
                     :amount => amount,
                     :credit_account => profit_account,
                     :debit_account => balance_account,
                     :value_date => Date.today)
      # write off rest if needed
      if balance > 0
        bookings.build(:title => "Debitorenverlust",
                       :comments => comments || "Reaktiviert",
                       :amount => balance,
                       :credit_account => profit_account,
                       :debit_account => balance_account,
                       :value_date => Date.today)
      end
    end
    
    self.state = 'reactivated'

    for session in sessions
      session.reactivate
    end
    
    return self
  end
  
  def write_off(comments = nil)
    if balance > 0
      bookings.build(:title => "Debitorenverlust",
                     :comments => comments || "Abgeschrieben",
                     :amount => balance,
                     :credit_account => profit_account,
                     :debit_account => balance_account,
                     :value_date => Date.today)
    end

    self.state = 'written_off'

    return self
  end

  def book_extra_earning(comments = nil)
    if balance < 0
      bookings.build(:title => "Ausserordentlicher Ertrag",
                     :comments => comments || "Zuviel bezahlt",
                     :amount => -balance,
                     :debit_account  => Account.find_by_code('1080'),
                     :credit_account => balance_account,
                     :value_date => Date.today)
    end

    return self
  end

  def cancel(comments = nil)
    # Cancel original amount
    booking = bookings.build(:title => "Storno",
                   :amount => amount,
                   :credit_account => profit_account,
                   :debit_account => balance_account,
                   :value_date => Date.today)
    booking.comments = comments if comments.present?

    # Cancel reset if needed
    if balance > 0
      bookings.build(:title => "Debitorenverlust",
                     :comments => "Storniert",
                     :amount => balance,
                     :credit_account => profit_account,
                     :debit_account => balance_account,
                     :value_date => Date.today)
    end

    self.state = 'canceled'

    return booking
  end
end
