class CreateAssets < ActiveRecord::Migration
  def self.up
    create_table :assets do |t|
      t.string :title
      t.text :remarks
      t.decimal :amount
      t.string :state
      t.belongs_to :invoice

      t.timestamps
    end
  end

  def self.down
    drop_table :assets
  end
end
