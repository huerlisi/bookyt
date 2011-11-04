class RenameVatRateToVatRateCodeInLineItems < ActiveRecord::Migration
  def change
    rename_column :line_items, :vat_rate, :vat_rate_code
  end
end
