class UseDecimalInDay < ActiveRecord::Migration
  def self.up
    change_column :days, :cash, :decimal
    change_column :days, :card_turnover, :decimal
    change_column :days, :gross_turnover, :decimal
    change_column :days, :net_turnover, :decimal
    change_column :days, :expenses, :decimal
    change_column :days, :credit_turnover, :decimal
  end

  def self.down
    change_column :days, :cash, :float
    change_column :days, :card_turnover, :float
    change_column :days, :gross_turnover, :float
    change_column :days, :net_turnover, :float
    change_column :days, :expenses, :float
    change_column :days, :credit_turnover, :float
  end
end
