class Day < ActiveRecord::Base
  def after_update
    cash_booking = Booking.new(:title => 'Bareinnahmen', :debit_account_id => 21, :credit_account_id => 1, :amount => cash, :value_date => date)
    cash_booking.save

    credit_booking = Booking.new(:title => 'Kreditkarten Einnahmen', :debit_account_id => 21, :credit_account_id => 49, :amount => card_turnover, :value_date => date)
    credit_booking.save
  end
end
