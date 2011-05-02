class AddDatesToTenants < ActiveRecord::Migration
  def self.up
    add_column :tenants, :incorporated_on, :date
    add_column :tenants, :first_fiscal_year_starts_on, :date
  end

  def self.down
    remove_column :tenants, :first_fiscal_year_starts_on
    remove_column :tenants, :incorporated_on
  end
end
