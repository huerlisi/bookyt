class AddCivilStatusToPeople < ActiveRecord::Migration
  def change
    add_column :people, :civil_status_id, :integer
  end
end
