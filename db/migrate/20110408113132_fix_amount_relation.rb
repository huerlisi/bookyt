class FixAmountRelation < ActiveRecord::Migration
  def self.up
    change_column_default :booking_templates, :amount_relates_to, nil
  end

  def self.down
  end
end
