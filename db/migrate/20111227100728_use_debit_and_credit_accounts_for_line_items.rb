class UseDebitAndCreditAccountsForLineItems < ActiveRecord::Migration
  def up
    add_column :line_items, :credit_account_id, :integer
    add_index :line_items, :credit_account_id

    add_column :line_items, :debit_account_id, :integer
    add_index :line_items, :debit_account_id

    LineItem.unscoped do
      LineItem.find_each do |line_item|
        invoice = line_item.invoice
        case invoice.class.name
        when "DebitInvoice"
          line_item.update_column(:credit_account_id, invoice.direct_account.id)
          line_item.update_column(:debit_account_id, line_item.contra_account_id)
        when "CreditInvoice"
          line_item.update_column(:credit_account_id, line_item.contra_account_id)
          line_item.update_column(:debit_account_id, invoice.direct_account.id)
        end
      end
    end

    remove_column :line_items, :contra_account_id
  end
end
