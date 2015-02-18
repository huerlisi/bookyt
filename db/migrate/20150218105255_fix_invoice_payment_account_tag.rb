class FixInvoicePaymentAccountTag < ActiveRecord::Migration
  def up
    account = Account.tagged_with('invoice_payment').where(code: '1020').first
    if account
      tags = account.tag_list
      account.tag_list = tags - ['invoice_payment'] + ['invoice:payment']
      account.save!
    end
  end

  def down
    account = Account.tagged_with('invoice:payment').where(code: '1020').first
    if account
      tags = account.tag_list
      account.tag_list = tags - ['invoice:payment'] + ['invoice_payment']
      account.save!
    end
  end
end
