class AddBookingTemplateIdToLineItems < ActiveRecord::Migration
  def change
    add_column :line_items, :booking_template_id, :integer
    add_index :line_items, :booking_template_id
  end
end
