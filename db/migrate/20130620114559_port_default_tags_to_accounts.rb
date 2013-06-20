class PortDefaultTagsToAccounts < ActiveRecord::Migration
  def set_tag(code, tag_list)
    account = Account.find_by_code(code)
    if account
      account.tag_list = tag_list
      account.save
    end
  end

  def up
    set_tag('1100', 'invoice:debit')
    set_tag('3200', 'invoice:earnings, vat:credit')
    set_tag('2000', 'invoice:credit')
    set_tag('4000', 'invoice:costs, vat:debit')
  end
end
