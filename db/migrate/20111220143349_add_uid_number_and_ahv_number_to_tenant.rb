class AddUidNumberAndAhvNumberToTenant < ActiveRecord::Migration
  def change
    add_column :tenants, :uid_number, :string
    add_column :tenants, :ahv_number, :string
  end
end
