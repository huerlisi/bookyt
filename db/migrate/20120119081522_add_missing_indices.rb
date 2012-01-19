class AddMissingIndices < ActiveRecord::Migration
  def change
    # User
    add_index :users, :authentication_token

    # Person
    add_index :people, :religion_id
    add_index :people, :civil_status_id

    # Note
    add_index :notes, [:note_of_sth_id, :note_of_sth_type]
    add_index :notes, :user_id

    # LineItem
    add_index :line_items, :type
    add_index :line_items, :code
    add_index :line_items, :position
    add_index :line_items, :date

    # Employment
    add_index :employments, :duration_from
    add_index :employments, :duration_to

    # ChargeRate
    add_index :charge_rates, :code
    add_index :charge_rates, :duration_from
    add_index :charge_rates, :duration_to

    # BookingTemplate
    add_index :booking_templates, :position
    add_index :booking_templates, :code
  end
end
