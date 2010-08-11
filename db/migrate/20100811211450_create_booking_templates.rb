class CreateBookingTemplates < ActiveRecord::Migration
  def self.up
    create_table :booking_templates do |t|
      t.string :title
      t.decimal :amount
      t.integer :credit_account_id
      t.integer :debit_account_id
      t.date :value_date
      t.text :comments

      t.timestamps
    end
  end

  def self.down
    drop_table :booking_templates
  end
end
