class CreateAdminTenants < ActiveRecord::Migration
  def change
    create_table :admin_tenants do |t|
      t.string :subdomain
      t.string :db_name
      t.boolean :active

      t.timestamps
    end
  end
end
