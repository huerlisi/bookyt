class CreateVesrTables < ActiveRecord::Migration
  def change
    create_table "esr_files", :force => true do |t|
      t.integer  "size"
      t.string   "content_type"
      t.string   "filename"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "remarks",      :default => ""
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
      t.string   "remarks",                                         :default => ""
      t.string   "state",                                                           :null => false
    end

    add_index "esr_records", ["booking_id"], :name => "index_esr_records_on_booking_id"
    add_index "esr_records", ["esr_file_id"], :name => "index_esr_records_on_esr_file_id"
    add_index "esr_records", ["invoice_id"], :name => "index_esr_records_on_invoice_id"  
  end
end
