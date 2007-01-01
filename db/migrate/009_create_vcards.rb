class CreateVcards < ActiveRecord::Migration
  def self.up
    create_table :vcards do |t|
      t.column "full_name", :string, :limit => 50
      t.column "nickname", :string, :limit => 50
      t.column "address", :integer
      t.column "billing_address_id", :integer
      t.column "address_id", :integer
      t.column "family_name", :string, :limit => 50
      t.column "given_name", :string, :limit => 50
      t.column "additional_name", :string, :limit => 50
      t.column "honorific_prefix", :string, :limit => 50
      t.column "honorific_suffix", :string, :limit => 50
    end
  end

  def self.down
    drop_table :vcards
  end
end
