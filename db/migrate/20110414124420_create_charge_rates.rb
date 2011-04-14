class CreateChargeRates < ActiveRecord::Migration
  def self.up
    create_table :charge_rates do |t|
      t.string :title
      t.string :code
      t.decimal :rate
      t.date :duration_from
      t.date :duration_to

      t.timestamps
    end
  end

  def self.down
    drop_table :charge_rates
  end
end
