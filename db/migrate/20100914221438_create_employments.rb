class CreateEmployments < ActiveRecord::Migration
  def self.up
    create_table :employments do |t|
      t.date :duration_from
      t.date :duration_to
      t.boolean :temporary
      t.boolean :hourly_paid
      t.decimal :daily_workload
      t.references :employee
      t.references :employer

      t.timestamps
    end
  end

  def self.down
    drop_table :employments
  end
end
