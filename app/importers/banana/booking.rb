# encoding: utf-8

module Banana
  class Booking
    def self.import(xml)
      xml.css('Table[@ID="Transactions"] RowList Row').each do |row|
        banana_date = row.css('Date').text
        banana_doc = row.css('Doc').text
        banana_description = row.css('Description').text
        banana_account_debit = row.css('AccountDebit').text
        banana_account_credit = row.css('AccountCredit').text
        banana_amount = row.css('Amount').text

        if banana_account_debit.present? && banana_account_credit.present?
          debit_account_id = ::Account.find_by_code(banana_account_debit.to_i).id
          credit_account_id = ::Account.find_by_code(banana_account_credit.to_i).id

          b = ::Booking.create!(
            title: banana_description,
            amount: banana_amount,
            debit_account_id: credit_account_id, # TODO: why stands credit_account_id for 'soll'?
            credit_account_id: debit_account_id, # TODO: why stands debit_account_id for 'haben'?
            value_date: banana_date,
            comments: banana_doc
          )
        end

      end
    end
  end
end
