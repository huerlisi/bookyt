class CreateProjectStates < ActiveRecord::Migration
  def change
    create_table :project_states do |t|
      t.string :name

      t.timestamps
    end
  end
end
