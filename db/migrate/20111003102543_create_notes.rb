class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.text    :content
      t.integer :user_id
      t.integer :note_of_sth_id
      t.string  :note_of_sth_type

      t.timestamps
    end
  end
end
