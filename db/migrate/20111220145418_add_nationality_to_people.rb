class AddNationalityToPeople < ActiveRecord::Migration
  def change
    add_column :people, :nationality, :string
  end
end
