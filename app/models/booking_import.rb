# encoding: utf-8

class BookingImport < Attachment
  require 'csv'

  # Default ordering
  default_scope order('created_at DESC')

  # Helper
  def to_s
    name = I18n::translate(self.class.model_name.underscore, :scope => 'activerecord.models')
    "%s (%s)" % [name, created_at]
  end

  # Transformation
  # ==============
  def parser
    # Use FasterCSV even in Ruby 1.8
    if CSV.const_defined? :Reader
      parser = FasterCSV
    else
      parser = CSV
    end
  end

  def rows
    csv = Iconv.iconv('utf-8', 'ISO-8859-1', file.read)[0]
    
    parser.parse(csv, :headers => true, :col_sep => ';')
  end

  # Import
  after_create :start_import

  def start_import
    booking = nil

    rows.each do |row|
      if row['Booked At']
        booking = Booking.new(
          :value_date => row['Valuta Date'],
          :amount     => row['Credit/Debit Amount'],
          :title      => row['Text']
        )

        if booking.amount < 0
          # Outgoing payment
          booking.credit_account = Account.find_by_code('1080')
          booking.debit_account = Account.find_by_code('1020')
          booking.amount = -booking.amount
        else
          # Incomming payment
          booking.credit_account = Account.find_by_code('1020')
          booking.debit_account = Account.find_by_code('1080')
        end
      else
        booking.comments = row['Text']
      end

      # Save booking, raise exception if something fails
      booking.save!
    end
  end
end
