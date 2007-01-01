class AccountHasNoSaldo < ActiveRecord::Migration
  def self.up
    remove_column :accounts, :saldo
  end

  def self.down
    add_column :accounts, :saldo, :float
  end
end
