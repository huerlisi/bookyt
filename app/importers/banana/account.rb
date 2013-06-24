# encoding: utf-8

module Banana
  class Account
    @balance_sheet_account_code = 9100

    def self.import(xml)
      ::AccountType.create!(
        name: 'balance_sheet_account',
        title: I18n.t('bookyt.balance_sheet_account')
      )

      balance_sheet_account = ::Account.create!(
        title: I18n.t('bookyt.balance_sheet_account'),
        code: @balance_sheet_account_code,
        account_type: AccountType.find_by_name('balance_sheet_account')
      )

      # set year of first booking as start of balance sheet year
      first_booking_date = xml.css('Table[@ID="Transactions"] RowList Row').first.css('Date').text
      balance_sheet_opening_date = Date.parse(first_booking_date).beginning_of_year

      xml.css('Table[@ID="Accounts"] RowList Row').each do |row|
        banana_account = row.css('Account').text
        banana_description = row.css('Description').text
        banana_bclass = row.css('BClass').text
        banana_opening = row.css('Opening').text

        if banana_account.present?
          type_name = convert_banana_bclass_to_bookyt_account_type(banana_account: banana_account, banana_bclass: banana_bclass.to_i)

          # TODO: log and show message
          next unless type_name

          account_type = AccountType.find_by_name(type_name)

          account = ::Account.create!(
            title: banana_description,
            code: banana_account,
            account_type: account_type
          )

          # set opening_balance_sheet_accout on soll or haben
          if banana_opening.present?
            if ['current_assets', 'capital_assets'].include? account_type.name
              debit_account_id = account.id
              credit_account_id = balance_sheet_account.id
            elsif ['outside_capital', 'equity_capital'].include? account_type.name
              debit_account_id = balance_sheet_account.id
              credit_account_id = account.id
            end

            # banana uses minus numbers for liability accounts
            banana_opening = banana_opening.to_f
            banana_opening *= -1 if ['outside_capital', 'equity_capital'].include? account_type.name

            b = ::Booking.create!(
              title: "Eröffnungsbuchung - #{banana_description}",
              amount: banana_opening,
              debit_account_id: credit_account_id,    # TODO: why stands credit_account_id for 'soll'?
              credit_account_id: debit_account_id,    # TODO: why stands debit_account_id for 'haben'?
              value_date: balance_sheet_opening_date,
              comments: ''
            )
          end
        end
      end
    end

    def self.convert_banana_bclass_to_bookyt_account_type(args)
      banana_account = args[:banana_account]
      banana_bclass  = args[:banana_bclass]

      # If banana account name starts with a number
      if banana_account.match /^\d/
        return 'current_assets'  if banana_bclass == 1 && banana_account.to_i.between?(1000, 1399)
        return 'capital_assets'  if banana_bclass == 1 && banana_account.to_i.between?(1400, 1799)
        return 'outside_capital' if banana_bclass == 2 && banana_account.to_i.between?(2000, 2799)
        return 'equity_capital'  if banana_bclass == 2 && banana_account.to_i.between?(2800, 2999)
        return 'costs'           if banana_bclass == 3
        return 'earnings'        if banana_bclass == 4
      end

      return 'current_assets' if banana_bclass == 1 && banana_account.starts_with?('D.')
      return 'outside_capital' if banana_bclass == 1 && banana_account.starts_with?('K.')
    end

    # def self.asset_account
    # end

  end
end
