class AddContraAccountToLineItems < ActiveRecord::Migration
  def change
    add_column :line_items, :contra_account_id, :integer

    add_index :line_items, :contra_account_id
  end
end
