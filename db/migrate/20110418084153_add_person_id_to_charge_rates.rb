class AddPersonIdToChargeRates < ActiveRecord::Migration
  def self.up
    add_column :charge_rates, :person_id, :integer
  end

  def self.down
    remove_column :charge_rates, :person_id
  end
end
