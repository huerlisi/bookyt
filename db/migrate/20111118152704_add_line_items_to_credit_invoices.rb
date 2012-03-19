class AddLineItemsToCreditInvoices < ActiveRecord::Migration
  def up
    invoices = CreditInvoice.all.select{|i| i.line_items.empty? }

    for invoice in invoices
      line_item = invoice.line_items.build(:title => invoice.title, :times => 1, :quantity => 'x', :price => invoice.amount, :contra_account_id => invoice.profit_account.id)
      line_item.save
    end
  end
end
