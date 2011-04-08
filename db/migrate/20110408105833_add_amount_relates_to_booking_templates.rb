class AddAmountRelatesToBookingTemplates < ActiveRecord::Migration
  def self.up
    add_column :booking_templates, :amount_relates_to, :string

    change_column :booking_templates, :amount, :string
  end

  def self.down
    change_column :booking_templates, :amount, :decimal

    remove_column :booking_templates, :amount_relates_to
  end
end
