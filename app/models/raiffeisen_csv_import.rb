class RaiffeisenCsvImport < BookingImport
  # Attachment
  belongs_to :booking_import_attachment

  # Account
  belongs_to :account

  # String helper
  def to_s
    begin
      "%s: %s - %s" % [account, start_date, end_date]
    rescue
    end
  end

  # Parsing
  def parse
    build_bookings

    self.account = Account.find_by_code('1020')
    self.start_date = bookings.first.value_date
    self.end_date = bookings.last.value_date
  end

  def rows
    return @rows if @rows

    @rows = CSV.parse(booking_import_attachment.content, :headers => true, :col_sep => ';')
  end

  def build_bookings
    todo_account = Account.find_by_code('1080')
    booking = nil

    rows.each do |row|
      if row['Booked At']
        booking = bookings.build(
          :value_date => Date.parse(row['Valuta Date']),
          :amount     => row['Credit/Debit Amount'],
          :title      => row['Text']
        )

        if booking.amount < 0
          # Outgoing payment
          booking.credit_account = todo_account
          booking.debit_account = account
          booking.amount = -booking.amount
        else
          # Incomming payment
          booking.credit_account = account
          booking.debit_account = todo_account
        end
      else
        booking.comments = row['Text']
      end
    end
  end
end
