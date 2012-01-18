class CreateSalaryItems < ActiveRecord::Migration
  def change
    create_table :salary_items do |t|
      t.integer :salary_booking_template_id
      t.integer :salary_template_id
      t.decimal :times, :precision => 10, :scale => 2
      t.decimal :price, :precision => 10, :scale => 2

      t.timestamps
    end

    add_index :salary_items, :salary_booking_template_id
    add_index :salary_items, :salary_template_id
  end
end
