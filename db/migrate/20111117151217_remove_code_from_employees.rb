class RemoveCodeFromEmployees < ActiveRecord::Migration
  def up
    remove_column :people, :code
  end

  def down
    add_column :people, :code, :string
  end
end
