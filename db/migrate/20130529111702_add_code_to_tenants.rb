class AddCodeToTenants < ActiveRecord::Migration
  def change
    add_column :tenants, :code, :string
  end
end
