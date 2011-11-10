class AddUseVesrToTenants < ActiveRecord::Migration
  def change
    add_column :tenants, :use_vesr, :boolean
  end
end
