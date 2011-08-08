class UseStringForPcIdAccountField < ActiveRecord::Migration
  def up
    change_column :accounts, :pc_id, :string
  end

  def down
  end
end
