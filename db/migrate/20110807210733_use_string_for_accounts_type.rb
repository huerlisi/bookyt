class UseStringForAccountsType < ActiveRecord::Migration
  def up
    change_column :accounts, :type, :string
  end

  def down
  end
end
