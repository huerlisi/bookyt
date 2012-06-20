class SetDefaultQuantityForLineItems < ActiveRecord::Migration
  def up
    LineItem.unscoped do
      LineItem.update_all("quantity = 'x'", "quantity IS NULL")
    end
  end

  def down
  end
end
