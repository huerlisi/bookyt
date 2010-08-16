# This file is auto-generated from the current state of the database. Instead 
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your 
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100816121822) do

  create_table "account_types", :force => true do |t|
    t.string "name",  :limit => 100
    t.string "title", :limit => 100
  end

  create_table "accounts", :force => true do |t|
    t.string  "title",           :limit => 100
    t.integer "client_id"
    t.integer "parent_id"
    t.integer "account_type_id"
    t.integer "number"
    t.string  "code"
    t.integer "type"
    t.integer "holder_id"
    t.string  "holder_type"
    t.integer "bank_id"
    t.integer "esr_id"
    t.integer "pc_id"
  end

  add_index "accounts", ["bank_id"], :name => "index_accounts_on_bank_id"
  add_index "accounts", ["code"], :name => "index_accounts_on_code"
  add_index "accounts", ["holder_id", "holder_type"], :name => "index_accounts_on_holder_id_and_holder_type"
  add_index "accounts", ["type"], :name => "index_accounts_on_type"

  create_table "booking_templates", :force => true do |t|
    t.string   "title"
    t.decimal  "amount"
    t.integer  "credit_account_id"
    t.integer  "debit_account_id"
    t.date     "value_date"
    t.text     "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "code"
  end

  create_table "bookings", :force => true do |t|
    t.string  "title",             :limit => 100
    t.decimal "amount"
    t.integer "credit_account_id"
    t.integer "debit_account_id"
    t.date    "value_date"
    t.text    "comments",          :limit => 1000, :default => ""
    t.string  "scan"
    t.string  "debit_currency",                    :default => "CHF"
    t.string  "credit_currency",                   :default => "CHF"
    t.float   "exchange_rate",                     :default => 1.0
  end

  create_table "clients", :force => true do |t|
    t.string "name", :limit => 100
  end

  create_table "days", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "date"
    t.float    "cash",            :default => 0.0
    t.float    "card_turnover",   :default => 0.0
    t.float    "gross_turnover",  :default => 0.0
    t.float    "net_turnover",    :default => 0.0
    t.integer  "client_count",    :default => 0
    t.integer  "product_count",   :default => 0
    t.float    "expenses",        :default => 0.0
    t.float    "credit_turnover", :default => 0.0
    t.decimal  "discount",        :default => 0.0
  end

  create_table "products", :force => true do |t|
  end

  create_table "vcards", :force => true do |t|
    t.string  "full_name",          :limit => 50
    t.string  "nickname",           :limit => 50
    t.integer "address"
    t.integer "billing_address_id"
    t.integer "address_id"
    t.string  "family_name",        :limit => 50
    t.string  "given_name",         :limit => 50
    t.string  "additional_name",    :limit => 50
    t.string  "honorific_prefix",   :limit => 50
    t.string  "honorific_suffix",   :limit => 50
  end

end
