class CreateReligions < ActiveRecord::Migration
  def change
    create_table :religions do |t|
      t.string :name

      t.timestamps
    end
  end
end
