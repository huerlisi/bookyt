class UseXInsteadOfTimesInLineItems < ActiveRecord::Migration
  def up
    LineItem.unscoped.where(:quantity => 'times').update_all(:quantity => 'x')
  end

  def down
    LineItem.unscoped.where(:quantity => 'x').update_all(:quantity => 'times')
  end
end
