class RemoveLocaleFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :locale
  end

  def down
    add_column :users, :locale, :string
  end
end
