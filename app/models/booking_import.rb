# encoding: utf-8

class BookingImport < ActiveRecord::Base
  # Access Restrictions
  attr_accessible :type, :account_id, :reference, :start_date, :end_date

  # Attachment
  belongs_to :booking_import_attachment
  attr_accessible :booking_import_attachment_id

  # Account
  belongs_to :account

  # Bookings
  has_many :bookings, :as => :template
  accepts_nested_attributes_for :bookings
  attr_accessible :bookings_attributes

  # String helper
  def to_s
    begin
      "%s: %s - %s" % [account, start_date, end_date]
    rescue
    end
  end
end
