# encoding: UTF-8
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

ActiveRecord::Schema.define(:version => 20130620221230) do

  create_table "account_types", :force => true do |t|
    t.string   "name",       :limit => 100
    t.string   "title",      :limit => 100
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "account_types", ["name"], :name => "index_account_types_on_name"

  create_table "accounts", :force => true do |t|
    t.string   "title",           :limit => 100
    t.integer  "parent_id"
    t.integer  "account_type_id"
    t.string   "number"
    t.string   "code"
    t.string   "type"
    t.integer  "holder_id"
    t.string   "holder_type"
    t.integer  "bank_id"
    t.integer  "esr_id"
    t.string   "pc_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "iban"
  end

  add_index "accounts", ["account_type_id"], :name => "index_accounts_on_account_type_id"
  add_index "accounts", ["bank_id"], :name => "index_accounts_on_bank_id"
  add_index "accounts", ["code"], :name => "index_accounts_on_code"
  add_index "accounts", ["holder_id", "holder_type"], :name => "index_accounts_on_holder_id_and_holder_type"
  add_index "accounts", ["type"], :name => "index_accounts_on_type"

  create_table "activities", :force => true do |t|
    t.date     "date"
    t.integer  "person_id"
    t.integer  "project_id"
    t.text     "remarks"
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
    t.decimal  "duration",    :precision => 4,  :scale => 2
    t.integer  "work_day_id"
    t.decimal  "hours_due",   :precision => 10, :scale => 2
  end

  add_index "activities", ["date"], :name => "index_activities_on_date"
  add_index "activities", ["person_id"], :name => "index_activities_on_person_id"
  add_index "activities", ["project_id"], :name => "index_activities_on_project_id"
  add_index "activities", ["work_day_id"], :name => "index_activities_on_work_day_id"

  create_table "addresses", :force => true do |t|
    t.string   "post_office_box",  :limit => 50
    t.string   "extended_address", :limit => 50
    t.string   "street_address",   :limit => 50
    t.string   "locality",         :limit => 50
    t.string   "region",           :limit => 50
    t.string   "postal_code",      :limit => 50
    t.string   "country_name",     :limit => 50
    t.integer  "vcard_id"
    t.string   "address_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "addresses", ["vcard_id"], :name => "addresses_vcard_id_index"

  create_table "assets", :force => true do |t|
    t.string   "title"
    t.text     "remarks"
    t.decimal  "amount",     :precision => 10, :scale => 0
    t.string   "state"
    t.integer  "invoice_id"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  create_table "attachments", :force => true do |t|
    t.string   "title"
    t.string   "file"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "object_id"
    t.string   "object_type"
    t.string   "code"
    t.string   "type"
    t.string   "encoding"
  end

  add_index "attachments", ["code"], :name => "index_attachments_on_code"
  add_index "attachments", ["object_id", "object_type"], :name => "index_attachments_on_object_id_and_object_type"

  create_table "booking_imports", :force => true do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.string   "reference"
    t.integer  "booking_import_attachment_id"
    t.integer  "account_id"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.string   "type"
  end

  add_index "booking_imports", ["account_id"], :name => "index_mt940_imports_on_account_id"
  add_index "booking_imports", ["booking_import_attachment_id"], :name => "index_mt940_imports_on_mt940_attachment_id"
  add_index "booking_imports", ["type"], :name => "index_booking_imports_on_type"

  create_table "booking_templates", :force => true do |t|
    t.string   "title"
    t.string   "amount"
    t.integer  "credit_account_id"
    t.integer  "debit_account_id"
    t.text     "comments"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.string   "code"
    t.string   "matcher"
    t.string   "amount_relates_to"
    t.string   "type"
    t.string   "charge_rate_code"
    t.string   "salary_declaration_code"
    t.integer  "position"
  end

  add_index "booking_templates", ["code"], :name => "index_booking_templates_on_code"
  add_index "booking_templates", ["credit_account_id"], :name => "index_booking_templates_on_credit_account_id"
  add_index "booking_templates", ["debit_account_id"], :name => "index_booking_templates_on_debit_account_id"
  add_index "booking_templates", ["position"], :name => "index_booking_templates_on_position"
  add_index "booking_templates", ["type"], :name => "index_booking_templates_on_type"

  create_table "bookings", :force => true do |t|
    t.string   "title",             :limit => 100
    t.decimal  "amount",                           :precision => 10, :scale => 2
    t.integer  "credit_account_id"
    t.integer  "debit_account_id"
    t.date     "value_date"
    t.text     "comments"
    t.string   "scan"
    t.string   "debit_currency",                                                  :default => "CHF"
    t.string   "credit_currency",                                                 :default => "CHF"
    t.float    "exchange_rate",                                                   :default => 1.0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "reference_id"
    t.string   "reference_type"
    t.integer  "code"
    t.integer  "template_id"
    t.string   "template_type"
  end

  add_index "bookings", ["credit_account_id"], :name => "index_bookings_on_credit_account_id"
  add_index "bookings", ["debit_account_id"], :name => "index_bookings_on_debit_account_id"
  add_index "bookings", ["reference_id", "reference_type"], :name => "index_bookings_on_reference_id_and_reference_type"
  add_index "bookings", ["template_id", "template_type"], :name => "index_bookings_on_template_id_and_template_type"
  add_index "bookings", ["value_date"], :name => "index_bookings_on_value_date"

  create_table "charge_rates", :force => true do |t|
    t.string   "title"
    t.string   "code"
    t.decimal  "rate",          :precision => 10, :scale => 2
    t.date     "duration_from"
    t.date     "duration_to"
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
    t.integer  "person_id"
    t.boolean  "relative"
  end

  add_index "charge_rates", ["code"], :name => "index_charge_rates_on_code"
  add_index "charge_rates", ["duration_from"], :name => "index_charge_rates_on_duration_from"
  add_index "charge_rates", ["duration_to"], :name => "index_charge_rates_on_duration_to"
  add_index "charge_rates", ["person_id"], :name => "index_charge_rates_on_person_id"

  create_table "civil_statuses", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

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

  create_table "employments", :force => true do |t|
    t.date     "duration_from"
    t.date     "duration_to"
    t.boolean  "temporary"
    t.boolean  "hourly_paid"
    t.decimal  "daily_workload",   :precision => 10, :scale => 2
    t.integer  "employee_id"
    t.integer  "employer_id"
    t.datetime "created_at",                                      :null => false
    t.datetime "updated_at",                                      :null => false
    t.text     "remarks"
    t.decimal  "salary_amount",    :precision => 10, :scale => 2
    t.integer  "kids"
    t.decimal  "workload",         :precision => 10, :scale => 2
    t.decimal  "overtime_premium", :precision => 10, :scale => 0
    t.decimal  "holiday_premium",  :precision => 10, :scale => 0
    t.decimal  "sunday_premium",   :precision => 10, :scale => 0
    t.decimal  "night_premium",    :precision => 10, :scale => 0
    t.text     "payment_to"
  end

  add_index "employments", ["duration_from"], :name => "index_employments_on_duration_from"
  add_index "employments", ["duration_to"], :name => "index_employments_on_duration_to"
  add_index "employments", ["employee_id"], :name => "index_employments_on_employee_id"
  add_index "employments", ["employer_id"], :name => "index_employments_on_employer_id"

  create_table "esr_files", :force => true do |t|
    t.string   "file"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "remarks"
  end

  create_table "esr_records", :force => true do |t|
    t.string   "bank_pc_id"
    t.string   "reference"
    t.decimal  "amount",            :precision => 8, :scale => 2
    t.string   "payment_reference"
    t.date     "payment_date"
    t.date     "transaction_date"
    t.date     "value_date"
    t.string   "microfilm_nr"
    t.string   "reject_code"
    t.string   "reserved"
    t.string   "payment_tax"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "esr_file_id"
    t.integer  "booking_id"
    t.integer  "invoice_id"
    t.text     "remarks"
    t.string   "state",                                           :null => false
  end

  add_index "esr_records", ["booking_id"], :name => "index_esr_records_on_booking_id"
  add_index "esr_records", ["esr_file_id"], :name => "index_esr_records_on_esr_file_id"
  add_index "esr_records", ["invoice_id"], :name => "index_esr_records_on_invoice_id"

  create_table "honorific_prefixes", :force => true do |t|
    t.integer "sex"
    t.string  "name"
    t.integer "position"
  end

  create_table "invoices", :force => true do |t|
    t.integer  "customer_id"
    t.integer  "company_id"
    t.date     "due_date"
    t.string   "state"
    t.datetime "created_at",                                                                :null => false
    t.datetime "updated_at",                                                                :null => false
    t.string   "title"
    t.text     "remarks"
    t.date     "value_date"
    t.string   "type"
    t.string   "code"
    t.date     "duration_from"
    t.date     "duration_to"
    t.text     "text"
    t.date     "reminder_due_date"
    t.date     "second_reminder_due_date"
    t.date     "third_reminder_due_date"
    t.boolean  "delta",                                                   :default => true, :null => false
    t.decimal  "leave_days_balance",       :precision => 4,  :scale => 2
    t.decimal  "used_leave_days",          :precision => 4,  :scale => 2
    t.decimal  "amount",                   :precision => 10, :scale => 2
    t.decimal  "due_amount",               :precision => 10, :scale => 2
  end

  add_index "invoices", ["company_id"], :name => "index_invoices_on_company_id"
  add_index "invoices", ["customer_id"], :name => "index_invoices_on_customer_id"
  add_index "invoices", ["state"], :name => "index_invoices_on_state"
  add_index "invoices", ["type"], :name => "index_invoices_on_type"
  add_index "invoices", ["value_date"], :name => "index_invoices_on_value_date"

  create_table "line_items", :force => true do |t|
    t.decimal  "times",               :precision => 10, :scale => 6
    t.decimal  "price",               :precision => 10, :scale => 2
    t.string   "code"
    t.string   "title"
    t.string   "description"
    t.integer  "item_id"
    t.string   "item_type"
    t.string   "type"
    t.integer  "invoice_id"
    t.datetime "created_at",                                                          :null => false
    t.datetime "updated_at",                                                          :null => false
    t.date     "date"
    t.string   "quantity",                                           :default => "x"
    t.integer  "credit_account_id"
    t.integer  "debit_account_id"
    t.integer  "booking_template_id"
    t.integer  "position"
    t.string   "reference_code"
  end

  add_index "line_items", ["booking_template_id"], :name => "index_line_items_on_booking_template_id"
  add_index "line_items", ["code"], :name => "index_line_items_on_code"
  add_index "line_items", ["credit_account_id"], :name => "index_line_items_on_credit_account_id"
  add_index "line_items", ["date"], :name => "index_line_items_on_date"
  add_index "line_items", ["debit_account_id"], :name => "index_line_items_on_debit_account_id"
  add_index "line_items", ["invoice_id"], :name => "index_line_items_on_invoice_id"
  add_index "line_items", ["item_id", "item_type"], :name => "index_line_items_on_item_id_and_item_type"
  add_index "line_items", ["position"], :name => "index_line_items_on_position"
  add_index "line_items", ["type"], :name => "index_line_items_on_type"

  create_table "people", :force => true do |t|
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
    t.string   "type"
    t.date     "date_of_birth"
    t.date     "date_of_death"
    t.integer  "sex"
    t.string   "social_security_nr"
    t.string   "social_security_nr_12"
    t.integer  "civil_status_id"
    t.integer  "religion_id"
    t.boolean  "delta",                 :default => true, :null => false
    t.string   "nationality"
    t.string   "swift"
    t.string   "clearing"
  end

  add_index "people", ["civil_status_id"], :name => "index_people_on_civil_status_id"
  add_index "people", ["religion_id"], :name => "index_people_on_religion_id"
  add_index "people", ["type"], :name => "index_people_on_type"

  create_table "phone_numbers", :force => true do |t|
    t.string   "number",            :limit => 50
    t.string   "phone_number_type", :limit => 50
    t.integer  "vcard_id"
    t.integer  "object_id"
    t.string   "object_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "phone_numbers", ["object_id", "object_type"], :name => "index_phone_numbers_on_object_id_and_object_type"
  add_index "phone_numbers", ["phone_number_type"], :name => "index_phone_numbers_on_phone_number_type"
  add_index "phone_numbers", ["vcard_id"], :name => "phone_numbers_vcard_id_index"

  create_table "products", :force => true do |t|
  end

  create_table "project_states", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.text     "remarks"
    t.date     "duration_from"
    t.date     "duration_to"
    t.integer  "project_state_id"
    t.integer  "client_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "projects", ["client_id"], :name => "index_projects_on_client_id"
  add_index "projects", ["project_state_id"], :name => "index_projects_on_project_state_id"

  create_table "religions", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  add_index "roles_users", ["role_id"], :name => "index_roles_users_on_role_id"
  add_index "roles_users", ["user_id"], :name => "index_roles_users_on_user_id"

  create_table "salary_booking_templates_salary_templates", :id => false, :force => true do |t|
    t.integer "salary_template_id"
    t.integer "salary_booking_template_id"
  end

  create_table "salary_items", :force => true do |t|
    t.integer  "salary_booking_template_id"
    t.integer  "salary_template_id"
    t.decimal  "times",                      :precision => 10, :scale => 2
    t.decimal  "price",                      :precision => 10, :scale => 2
    t.datetime "created_at",                                                :null => false
    t.datetime "updated_at",                                                :null => false
    t.integer  "position"
  end

  add_index "salary_items", ["position"], :name => "index_salary_items_on_position"
  add_index "salary_items", ["salary_booking_template_id"], :name => "index_salary_items_on_salary_booking_template_id"
  add_index "salary_items", ["salary_template_id"], :name => "index_salary_items_on_salary_template_id"

  create_table "salary_templates", :force => true do |t|
    t.integer  "person_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "title"
    t.text     "remarks"
  end

  add_index "salary_templates", ["person_id"], :name => "index_salary_templates_on_person_id"

  create_table "settings", :force => true do |t|
    t.string   "var",                       :null => false
    t.text     "value"
    t.integer  "target_id"
    t.string   "target_type", :limit => 30
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "settings", ["target_type", "target_id", "var"], :name => "index_settings_on_target_type_and_target_id_and_var", :unique => true

  create_table "stocks", :force => true do |t|
    t.string   "title"
    t.text     "remarks"
    t.decimal  "amount",              :precision => 10, :scale => 2
    t.string   "state"
    t.integer  "purchase_invoice_id"
    t.datetime "created_at",                                         :null => false
    t.datetime "updated_at",                                         :null => false
    t.integer  "selling_invoice_id"
  end

  add_index "stocks", ["purchase_invoice_id"], :name => "index_assets_on_purchase_invoice_id"
  add_index "stocks", ["selling_invoice_id"], :name => "index_assets_on_selling_invoice_id"
  add_index "stocks", ["state"], :name => "index_assets_on_state"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "tenants", :force => true do |t|
    t.integer  "person_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.date     "incorporated_on"
    t.date     "fiscal_year_ends_on"
    t.string   "vat_number"
    t.boolean  "use_vesr"
    t.boolean  "print_payment_for"
    t.string   "uid_number"
    t.string   "ahv_number"
  end

  add_index "tenants", ["person_id"], :name => "index_tenants_on_person_id"

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.integer  "person_id"
    t.integer  "tenant_id"
    t.string   "authentication_token"
    t.datetime "reset_password_sent_at"
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token"
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["person_id"], :name => "index_users_on_person_id"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["tenant_id"], :name => "index_users_on_tenant_id"

  create_table "vcards", :force => true do |t|
    t.string   "full_name",        :limit => 50
    t.string   "nickname",         :limit => 50
    t.string   "family_name",      :limit => 50
    t.string   "given_name",       :limit => 50
    t.string   "additional_name",  :limit => 50
    t.string   "honorific_prefix", :limit => 50
    t.string   "honorific_suffix", :limit => 50
    t.boolean  "active",                         :default => true
    t.integer  "object_id"
    t.string   "object_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "vcards", ["active"], :name => "index_vcards_on_active"
  add_index "vcards", ["object_id", "object_type"], :name => "index_vcards_on_object_id_and_object_type"

  create_table "work_days", :force => true do |t|
    t.integer  "person_id"
    t.date     "date"
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
    t.decimal  "hours_due",    :precision => 10, :scale => 2
    t.decimal  "hours_worked", :precision => 10, :scale => 2
  end

  add_index "work_days", ["date"], :name => "index_work_days_on_date"
  add_index "work_days", ["person_id"], :name => "index_work_days_on_person_id"

end
