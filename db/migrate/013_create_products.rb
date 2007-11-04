class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
    end
  end

  def self.down
    drop_table :products
  end
end
