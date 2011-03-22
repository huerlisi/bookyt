class BookingReference < ActiveRecord::Base
  belongs_to :booking
  belongs_to :reference, :polymorphic => true
end
