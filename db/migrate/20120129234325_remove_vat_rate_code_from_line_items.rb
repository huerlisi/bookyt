class RemoveVatRateCodeFromLineItems < ActiveRecord::Migration
  def up
    remove_column :line_items, :vat_rate_code
  end

  def down
    add_column :line_items, :vat_rate_code, :string
  end
end
