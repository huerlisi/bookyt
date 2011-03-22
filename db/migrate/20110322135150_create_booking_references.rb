class CreateBookingReferences < ActiveRecord::Migration
  def self.up
    create_table :booking_references do |t|
      t.references :booking
      t.string :kind
      t.references :reference, :polymorphic => true

      t.timestamps
    end
  end

  def self.down
    drop_table :booking_references
  end
end
