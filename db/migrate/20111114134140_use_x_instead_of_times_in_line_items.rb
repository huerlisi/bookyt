class UseXInsteadOfTimesInLineItems < ActiveRecord::Migration
  def up
    LineItem.unscoped do
      LineItem.where(:quantity => 'times').update_all(:quantity => 'x')
    end
  end

  def down
    LineItem.unscoped do
      LineItem.where(:quantity => 'x').update_all(:quantity => 'times')
    end
  end
end
