class AddDefaultQuantityToLineItems < ActiveRecord::Migration
  def change
    change_column_default :line_items, :quantity, 'x'
  end
end
