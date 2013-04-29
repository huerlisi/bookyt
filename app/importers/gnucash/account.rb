module Gnucash
  class Account
    def self.import(xml)
      parsed = Nokogiri.XML(xml)
  
      parsed.css('account').each do |account|
        # GnuCash types: "ASSET", "CASH", "BANK", "RECEIVABLE", "LIABILITY", "INCOME", "EXPENSE"
        # Bookyt types: "capital_assets", "costs", "current_assets", "earnings", "equity_capital", "outside_capital"
        case account.at_css('type').text
        when 'ASSET', 'CASH', 'BANK'
          type_name = 'current_assets'
        when 'INCOME' 
          type_name = 'earnings'
        when 'EXPENSE' 
          type_name = 'costs'
        when 'RECEIVABLE' 
          type_name = 'capital_assets'
        when 'LIABILITY' 
          type_name = 'outside_capital'
        end

        account_type = AccountType.find_by_name(type_name)

        a = ::Account.create!(
          :title => account.at_css('name').text,
          :code => account.at_css('code').text.delete('.'),
          :account_type => account_type
        )
      end
    end
  end
end
