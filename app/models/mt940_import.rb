class Mt940Import < ActiveRecord::Base
  # Attachment
  belongs_to :mt940_attachment

  # Records
  has_many :mt940_records, :inverse_of => :mt940_import

  # Account
  belongs_to :account
  def account_identifier
    by_class(MT940::AccountIdentification).first.account_identifier
  end

  # String helper
  def to_s
    begin
      "%s: %s - %s" % [account, start_date, end_date]
    rescue
    end
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

    @mt940 = MT940.parse(mt940_attachment.content).first
  end

  def by_class(klass)
    mt940.select{|s| s.class == klass}
  end

  # Bookings
  has_many :bookings, :as => :template
  accepts_nested_attributes_for :bookings
  
  def build_bookings
    todo_account = Account.find_by_code('1080')
    booking = nil

    mt940.each do |line|
      if line.class == MT940::StatementLine
        booking = bookings.build
        booking.title = line.transaction_description[16..-1]
        booking.amount = line.amount / 100.0
        booking.value_date = line.value_date
        case line.funds_code
        when :credit
          booking.credit_account = account
          # VESR handling
          if booking.title =~ /[0-9]{27}/
            booking.debit_account  = Account.find_by_code('1100')
          else
            booking.debit_account  = todo_account
          end
        when :debit
          booking.credit_account = todo_account
          booking.debit_account  = account
        end
      end

      if line.class == MT940::InformationToAccountOwner
        narrative = line.narrative
        narrative[0].match(/BENM\/(.*)/)
        booking.comments = $1
      end
    end
  end
end
