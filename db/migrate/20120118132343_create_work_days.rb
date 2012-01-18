class CreateWorkDays < ActiveRecord::Migration
  def change
    create_table :work_days do |t|
      t.integer :person_id
      t.date    :date
      t.decimal :daily_workload, :precision => 10, :scale => 2

      t.timestamps
    end
  end
end
