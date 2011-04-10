class Asset < ActiveRecord::Base
  # Invoice
  belongs_to :invoice

  # Bookings
  # ========
  include HasAccounts::Model
end
