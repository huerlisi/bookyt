class DropTableDays < ActiveRecord::Migration
  def up
    drop_table :days
  end

  def down
    create_table "days", :force => true do |t|
      t.datetime "created_at"
      t.datetime "updated_at"
      t.date     "date"
      t.decimal  "cash",            :precision => 10, :scale => 2
      t.decimal  "card_turnover",   :precision => 10, :scale => 2
      t.decimal  "gross_turnover",  :precision => 10, :scale => 2
      t.decimal  "net_turnover",    :precision => 10, :scale => 2
      t.integer  "client_count"
      t.integer  "product_count"
      t.decimal  "expenses",        :precision => 10, :scale => 2
      t.decimal  "credit_turnover", :precision => 10, :scale => 2, :default => 0.0
      t.decimal  "discount",        :precision => 10, :scale => 2, :default => 0.0
    end
  end
end
