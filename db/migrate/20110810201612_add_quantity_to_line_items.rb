class AddQuantityToLineItems < ActiveRecord::Migration
  def change
    rename_column :line_items, :quantity, :times

    add_column :line_items, :quantity, :string
  end
end
