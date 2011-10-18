class AddTypeToChargeRates < ActiveRecord::Migration
  def change
    add_column :charge_rates, :type, :string
  end
end
