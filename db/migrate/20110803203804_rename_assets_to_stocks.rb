class RenameAssetsToStocks < ActiveRecord::Migration
  def up
#    rename_table :assets, :stocks
    
    execute "UPDATE attachments SET object_type = 'Stock' WHERE object_type = 'Asset'"
    execute "UPDATE bookings SET reference_type = 'Stock' WHERE reference_type = 'Asset'"
    execute "UPDATE booking_templates SET code = REPLACE(code, 'asset:', 'stock:') WHERE code LIKE '%asset:%'"
  end

  def down
    execute "UPDATE attachments SET object_type = 'Asset' WHERE object_type = 'Stock'"
    execute "UPDATE bookings SET reference_type = 'Asset' WHERE reference_type = 'Stock'"
    execute "UPDATE booking_templates SET code = REPLACE(code, 'stock:', 'asset:') WHERE code LIKE '%stock:%'"

    rename_table :stocks, :assets
  end
end
