class UseDirectReferencInBooking < ActiveRecord::Migration
  def self.up
    drop_table :booking_references
    
    add_column :bookings, :reference_id, :integer
    add_column :bookings, :reference_type, :string
  end

  def self.down
    remove_column :bookings, :reference_id
    remove_column :bookings, :reference_type

    create_table :booking_references do |t|
      t.references :booking
      t.string :kind
      t.references :reference, :polymorphic => true

      t.timestamps
    end
  end
end
