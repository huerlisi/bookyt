class Asset < ActiveRecord::Base
  # Invoice
  belongs_to :invoice

  # Validations
  validates_presence_of :title, :amount, :state

  # Bookings
  # ========
  include HasAccounts::Model
end
