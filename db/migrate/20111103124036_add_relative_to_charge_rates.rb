class AddRelativeToChargeRates < ActiveRecord::Migration
  def change
    add_column :charge_rates, :relative, :boolean
  end
end
