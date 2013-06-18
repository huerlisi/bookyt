module Banana
  class Account
    def self.import(xml)
      xml.css('Table[@ID="Accounts"] RowList Row').each do |row|
        banana_account = row.css('Account').text
        banana_description = row.css('Description').text
        banana_bclass = row.css('BClass').text

        if banana_account.present?
          type_name = convert_banana_bclass_to_bookyt_account_type(banana_account: banana_account.to_i, banana_bclass: banana_bclass.to_i)
          account_type = AccountType.find_by_name(type_name)

          a = ::Account.create!(
            title: banana_description,
            code: banana_account,
            account_type: account_type
          )
        end
      end
    end

    def self.convert_banana_bclass_to_bookyt_account_type(args)
      banana_account = args[:banana_account]
      banana_bclass  = args[:banana_bclass]

      return 'current_assets'  if banana_bclass == 1 && banana_account.between?(1000, 1399)
      return 'capital_assets'  if banana_bclass == 1 && banana_account.between?(1400, 1799)
      return 'outside_capital' if banana_bclass == 2 && banana_account.between?(2000, 2799)
      return 'equity_capital'  if banana_bclass == 2 && banana_account.between?(2800, 2999)
      return 'costs'           if banana_bclass == 3
      return 'earnings'        if banana_bclass == 4
    end
  end
end
