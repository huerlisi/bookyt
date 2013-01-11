class CreateTenants < ActiveRecord::Migration
  def self.up
    create_table :tenants do |t|
      t.integer :person_id

      t.timestamps
    end
    add_index :tenants, :person_id
  end

  def self.down
    drop_table :tenants
  end
end
