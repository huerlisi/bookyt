class TenantShouldRecordEndOfFiscalYear < ActiveRecord::Migration
  def self.up
    add_column :tenants, :fiscal_year_ends_on, :date
    remove_column :tenants, :first_fiscal_year_starts_on
  end

  def self.down
  end
end
