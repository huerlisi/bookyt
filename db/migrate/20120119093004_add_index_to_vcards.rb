class AddIndexToVcards < ActiveRecord::Migration
  def change
    add_index :vcards, :active
  end
end
