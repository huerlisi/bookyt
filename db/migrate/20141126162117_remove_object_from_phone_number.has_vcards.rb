# This migration comes from has_vcards (originally 20140619101337)
class RemoveObjectFromPhoneNumber < ActiveRecord::Migration
  def change
    remove_column :has_vcards_phone_numbers, :object_id
    remove_column :has_vcards_phone_numbers, :object_type
  end
end
