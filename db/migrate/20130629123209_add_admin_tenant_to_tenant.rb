class AddAdminTenantToTenant < ActiveRecord::Migration
  def change
    add_column :tenants, :admin_tenant_id, :integer
    add_index :tenants, :admin_tenant_id
  end
end
