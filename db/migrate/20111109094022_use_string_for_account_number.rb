class UseStringForAccountNumber < ActiveRecord::Migration
  def up
    change_column :accounts, :number, :string
  end

  def down
    change_column :accounts, :number, :integer
  end
end
