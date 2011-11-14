class UseXInsteadOfTimesInLineItems < ActiveRecord::Migration
  def up
    LineItem.where(:quantity => 'times').update_all(:quantity => 'x')
  end

  def down
    LineItem.where(:quantity => 'x').update_all(:quantity => 'times')
  end
end
