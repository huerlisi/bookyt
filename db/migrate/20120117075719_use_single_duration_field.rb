class UseSingleDurationField < ActiveRecord::Migration
  def up
    add_column :activities, :duration, :datetime
    
    remove_column :activities, :duration_from
    remove_column :activities, :duration_to
  end
end
