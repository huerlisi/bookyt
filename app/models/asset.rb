class Asset < ActiveRecord::Base
  # Invoice
  belongs_to :invoice

  # Validations
  validates_presence_of :title, :amount, :state

  # Bookings
  # ========
  include HasAccounts::Model
  
  def direct_account
    # We don't care if no bookings
    return nil if bookings.empty?
    
    # Take any booking
    booking = bookings.first
    involved_accounts = [booking.credit_account, booking.debit_account]
    
    relevant_account = involved_accounts - [Account.find_by_code("1100"), Account.find_by_code("2000")]
    
    return relevant_account.first
  end
end
