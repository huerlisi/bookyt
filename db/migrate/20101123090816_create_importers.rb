class CreateImporters < ActiveRecord::Migration
  def self.up
    create_table :importers do |t|
      t.string    :csv_file_name
      t.string    :csv_content_type
      t.integer   :csv_file_size
      t.datetime  :csv_updated_at

      t.timestamps
    end
  end

  def self.down
    drop_table :importers
  end
end
