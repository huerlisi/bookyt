class UpgradeToDevise2 < ActiveRecord::Migration
  def up
    remove_column :users, :remember_token

    add_column :users, :reset_password_sent_at, :datetime
  end
end
