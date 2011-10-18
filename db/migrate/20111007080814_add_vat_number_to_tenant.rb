class AddVatNumberToTenant < ActiveRecord::Migration
  def change
    add_column :tenants, :vat_number, :string
  end
end
