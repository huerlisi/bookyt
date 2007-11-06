class ImproveCashUp < ActiveRecord::Migration
  def self.up
    rename_column :days, :cards, :card_turnover
    add_column :days, :gross_turnover, :float
    add_column :days, :net_turnover, :float
    add_column :days, :client_count, :integer
    add_column :days, :product_count, :integer
    add_column :days, :expenses, :float
    remove_column :days, :tip
    remove_column :days, :error
  end

  def self.down
  end
end
