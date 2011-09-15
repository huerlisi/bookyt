class AddVatRateToLineItems < ActiveRecord::Migration
  def change
    add_column :line_items, :vat_rate, :string
  end
end
