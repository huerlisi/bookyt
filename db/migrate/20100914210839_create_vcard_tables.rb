class CreateVcardTables < ActiveRecord::Migration
  def self.up
    drop_table :vcards
    
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

    create_table "vcards", :force => true do |t|
      t.string  "full_name",        :limit => 50
      t.string  "nickname",         :limit => 50
      t.string  "family_name",      :limit => 50
      t.string  "given_name",       :limit => 50
      t.string  "additional_name",  :limit => 50
      t.string  "honorific_prefix", :limit => 50
      t.string  "honorific_suffix", :limit => 50
      t.boolean "active",                         :default => true
      t.string  "type"
      t.integer "object_id"
      t.string  "object_type"
    end

    add_index "vcards", ["object_id", "object_type"], :name => "index_vcards_on_object_id_and_object_type"
  end

  def self.down
    drop_table :vcards, :phone_numbers, :addresses
  end
end
