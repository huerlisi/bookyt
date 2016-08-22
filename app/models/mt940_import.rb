class Mt940Import < BookingImport
  # Records
  has_many :mt940_records, :inverse_of => :mt940_import

  # Account
  def account_identifier
    by_class(MT940::AccountIdentification).first.account_identifier
  end

  # Parsing
  def parse
    self.reference = by_class(MT940::Job).first.reference
    self.start_date = by_class(MT940::OpeningBalance).first.date
    self.end_date = by_class(MT940::ClosingBalance).first.date
    self.account = BankAccount.where("REPLACE(iban, ' ', '') = ?", account_identifier).first

    build_bookings
  end

  def mt940
    return @mt940 if @mt940

    @mt940 = MT940.parse(booking_import_attachment.content).first
  end

  def by_class(klass)
    mt940.select{|s| s.class == klass}
  end

  # Bookings
  def build_bookings
    todo_account = Account.find_by_code('1080')
    booking = nil

    mt940.each do |line|
      if line.class == MT940::StatementLine
        booking = bookings.build
        booking.amount = line.amount / 100.0
        booking.value_date = line.value_date
        case line.funds_code
        when :debit
          booking.credit_account = account
          booking.debit_account  = todo_account
        when :credit
          booking.credit_account = todo_account
          booking.debit_account  = account
        end
      end

      if line.class == MT940::InformationToAccountOwner
        booking.title = line.narrative.first

        entries = line.narrative[1..-1].join()
        entries.gsub!(/--/, "\n---\n")
        entries.gsub!(/,/, "\n")
        comments = entries.lines.map(&:strip!).join("\n")

        booking.comments = comments
      end
    end
  end
end
