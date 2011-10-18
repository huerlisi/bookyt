class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.date :when
      t.datetime :from
      t.datetime :to
      t.integer :person_id
      t.integer :project_id
      t.string :comment

      t.timestamps
    end
  end
end
