class AddPositionToBookingTemplates < ActiveRecord::Migration
  def change
    add_column :booking_templates, :position, :integer
  end
end
