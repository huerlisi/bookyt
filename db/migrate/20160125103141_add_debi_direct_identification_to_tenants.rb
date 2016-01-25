class AddDebiDirectIdentificationToTenants < ActiveRecord::Migration
  def change
    add_column :tenants, :debit_direct_identification, :string
  end
end
