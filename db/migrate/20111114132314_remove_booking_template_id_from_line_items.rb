class RemoveBookingTemplateIdFromLineItems < ActiveRecord::Migration
  def up
    remove_index :line_items, :booking_template_id
    remove_column :line_items, :booking_template_id
  end

  def down
    add_column :line_items, :booking_template_id, :integer
    add_index :line_items, :booking_template_id
  end
end
