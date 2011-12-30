class AddTemplateToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :template_id, :integer
    add_column :bookings, :template_type, :string

    add_index :bookings, [:template_id, :template_type]
  end
end
