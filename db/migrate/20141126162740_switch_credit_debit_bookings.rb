class SwitchCreditDebitBookings < ActiveRecord::Migration
  def up
    Booking.update_all('credit_account_id = debit_account_id, debit_account_id = credit_account_id')
  end
end
