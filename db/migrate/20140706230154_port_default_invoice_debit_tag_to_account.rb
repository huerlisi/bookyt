class PortDefaultInvoiceDebitTagToAccount < ActiveRecord::Migration
  def set_tag(code, tag_list)
    account = Account.find_by_code(code)
    if account
      account.tag_list = tag_list
      account.save
    end
  end

  def up
    set_tag('1020', 'invoice:payment')
  end
end
