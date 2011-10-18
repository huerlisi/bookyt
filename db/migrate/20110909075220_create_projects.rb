class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.text :comment
      t.date :from
      t.date :to
      t.integer :project_state_id
      t.integer :client_id

      t.timestamps
    end
  end
end
