class AddScaleToDecimals < ActiveRecord::Migration
  def self.up
    change_column :assets, :amount, :decimal, :precision => 10, :scale => 2

    change_column :bookings, :amount, :decimal, :precision => 10, :scale => 2

    change_column :charge_rates, :rate, :decimal, :precision => 10, :scale => 2

    change_column :days, :cash, :decimal, :precision => 10, :scale => 2
    change_column :days, :card_turnover, :decimal, :precision => 10, :scale => 2
    change_column :days, :gross_turnover, :decimal, :precision => 10, :scale => 2
    change_column :days, :net_turnover, :decimal, :precision => 10, :scale => 2
    change_column :days, :expenses, :decimal, :precision => 10, :scale => 2
    change_column :days, :credit_turnover, :decimal, :precision => 10, :scale => 2
    change_column :days, :discount, :decimal, :precision => 10, :scale => 2

    change_column :employments, :daily_workload, :decimal, :precision => 10, :scale => 2
    change_column :employments, :salary_amount, :decimal, :precision => 10, :scale => 2
    change_column :employments, :workload, :decimal, :precision => 10, :scale => 2

    change_column :invoices, :amount, :decimal, :precision => 10, :scale => 2
  end

  def self.down
  end
end
