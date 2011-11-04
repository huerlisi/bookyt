class RemoveTypeFromChargeRates < ActiveRecord::Migration
  def up
    remove_column :charge_rates, :type
  end

  def down
    add_column :charge_rates, :type, :string
  end
end
