class SetAssetStateToAvailable < ActiveRecord::Migration
  def self.up
    Asset.update_all(:state => 'available')
  end

  def self.down
  end
end
