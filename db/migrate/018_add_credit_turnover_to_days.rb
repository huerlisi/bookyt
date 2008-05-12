class AddCreditTurnoverToDays < ActiveRecord::Migration
  def self.up
    add_column :days, :credit_turnover, :float, :default => 0.0
  end

  def self.down
    remove_column :days, :credit_turnover
  end
end
