class AddDiscountToDays < ActiveRecord::Migration
  def self.up
    add_column :days, :discount, :decimal, :default => 0.0
  end

  def self.down
    remove_column :days, :discount
  end
end
