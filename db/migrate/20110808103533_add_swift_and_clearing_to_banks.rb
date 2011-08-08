class AddSwiftAndClearingToBanks < ActiveRecord::Migration
  def change
    add_column :banks, :swift, :string
    add_column :banks, :clearing, :string
  end
end
