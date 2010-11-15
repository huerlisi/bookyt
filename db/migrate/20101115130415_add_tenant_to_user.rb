class AddTenantToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :tenant_id, :integer
  end

  def self.down
    remove_column :users, :tenant_id
  end
end
