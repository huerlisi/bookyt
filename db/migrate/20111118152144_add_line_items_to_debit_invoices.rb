class AddLineItemsToDebitInvoices < ActiveRecord::Migration
  def up
    invoices = DebitInvoice.all.select{|i| i.line_items.empty? }

    for invoice in invoices
      line_item = invoice.line_items.build(:title => invoice.title, :times => 1, :quantity => 'x', :price => invoice.amount, :contra_account => invoice.profit_account)
      line_item.save
    end
  end
end
