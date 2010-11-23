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

ActiveRecord::Schema.define(:version => 20101123090816) do

  create_table "account_types", :force => true do |t|
    t.string "name",  :limit => 100
    t.string "title", :limit => 100
  end

  create_table "accounts", :force => true do |t|
    t.string  "title",           :limit => 100
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

  create_table "addresses", :force => true do |t|
    t.string  "post_office_box",  :limit => 50
    t.string  "extended_address", :limit => 50
    t.string  "street_address",   :limit => 50
    t.string  "locality",         :limit => 50
    t.string  "region",           :limit => 50
    t.string  "postal_code",      :limit => 50
    t.string  "country_name",     :limit => 50
    t.integer "vcard_id"
    t.string  "address_type"
  end

  add_index "addresses", ["vcard_id"], :name => "addresses_vcard_id_index"

  create_table "booking_templates", :force => true do |t|
    t.string   "title"
    t.decimal  "amount",            :precision => 10, :scale => 0
    t.integer  "credit_account_id"
    t.integer  "debit_account_id"
    t.text     "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "code"
  end

  create_table "bookings", :force => true do |t|
    t.string  "title",             :limit => 100
    t.decimal "amount",                           :precision => 10, :scale => 0
    t.integer "credit_account_id"
    t.integer "debit_account_id"
    t.date    "value_date"
    t.text    "comments"
    t.string  "scan"
    t.string  "debit_currency",                                                  :default => "CHF"
    t.string  "credit_currency",                                                 :default => "CHF"
    t.float   "exchange_rate",                                                   :default => 1.0
  end

  create_table "days", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "date"
    t.decimal  "cash",            :precision => 10, :scale => 0, :default => 0
    t.decimal  "card_turnover",   :precision => 10, :scale => 0, :default => 0
    t.decimal  "gross_turnover",  :precision => 10, :scale => 0, :default => 0
    t.decimal  "net_turnover",    :precision => 10, :scale => 0, :default => 0
    t.integer  "client_count",                                   :default => 0
    t.integer  "product_count",                                  :default => 0
    t.decimal  "expenses",        :precision => 10, :scale => 0, :default => 0
    t.decimal  "credit_turnover", :precision => 10, :scale => 0, :default => 0
    t.decimal  "discount",        :precision => 10, :scale => 0, :default => 0
  end

  create_table "employments", :force => true do |t|
    t.date     "duration_from"
    t.date     "duration_to"
    t.boolean  "temporary"
    t.boolean  "hourly_paid"
    t.decimal  "daily_workload", :precision => 10, :scale => 0
    t.integer  "employee_id"
    t.integer  "employer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "importers", :force => true do |t|
    t.string   "csv_file_name"
    t.string   "csv_content_type"
    t.integer  "csv_file_size"
    t.datetime "csv_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invoices", :force => true do |t|
    t.integer  "customer_id"
    t.integer  "company_id"
    t.date     "due_date"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.text     "remarks"
    t.decimal  "amount",      :precision => 10, :scale => 0
  end

  create_table "people", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
    t.date     "date_of_birth"
    t.date     "date_of_death"
    t.integer  "sex"
  end

  create_table "phone_numbers", :force => true do |t|
    t.string  "number",            :limit => 50
    t.string  "phone_number_type", :limit => 50
    t.integer "vcard_id"
    t.integer "object_id"
    t.string  "object_type"
  end

  add_index "phone_numbers", ["object_id", "object_type"], :name => "index_phone_numbers_on_object_id_and_object_type"
  add_index "phone_numbers", ["phone_number_type"], :name => "index_phone_numbers_on_phone_number_type"
  add_index "phone_numbers", ["vcard_id"], :name => "phone_numbers_vcard_id_index"

  create_table "products", :force => true do |t|
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "tenants", :force => true do |t|
    t.integer  "person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "password_salt",                       :default => "", :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "person_id"
    t.integer  "tenant_id"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "vcards", :force => true do |t|
    t.string  "full_name",        :limit => 50
    t.string  "nickname",         :limit => 50
    t.string  "family_name",      :limit => 50
    t.string  "given_name",       :limit => 50
    t.string  "additional_name",  :limit => 50
    t.string  "honorific_prefix", :limit => 50
    t.string  "honorific_suffix", :limit => 50
    t.boolean "active",                         :default => true
    t.integer "object_id"
    t.string  "object_type"
  end

  add_index "vcards", ["object_id", "object_type"], :name => "index_vcards_on_object_id_and_object_type"

end
