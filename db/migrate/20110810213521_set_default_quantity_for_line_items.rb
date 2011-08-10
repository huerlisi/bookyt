class SetDefaultQuantityForLineItems < ActiveRecord::Migration
  def up
    LineItem.update_all("quantity = 'x'", "quantity IS NULL")
  end

  def down
  end
end
