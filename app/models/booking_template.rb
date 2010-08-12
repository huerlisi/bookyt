class BookingTemplate < ActiveRecord::Base
  # Associations
  belongs_to :debit_account, :foreign_key => 'debit_account_id', :class_name => "Account"
  belongs_to :credit_account, :foreign_key => 'credit_account_id', :class_name => "Account"

  # Standard methods
  def to_s(format = :default)
    case format
    when :short
      "%s: %s / %s CHF %s" % [
        value_date ? value_date : '?',
        credit_account ? credit_account.code : '?',
        debit_account ? debit_account.code : '?',
        amount ? "%0.2f" % amount : '?',
      ]
    else
      "%s: %s an %s CHF %s, %s (%s)" % [
        value_date ? value_date : '?',
        credit_account ? "#{credit_account.title} (#{credit_account.code})" : '?',
        debit_account ? "#{debit_account.title} (#{debit_account.code})" : '?',
        amount ? "%0.2f" % amount : '?',
        title ? title : '?',
        comments ? comments : '?'
      ]
    end
  end
end
