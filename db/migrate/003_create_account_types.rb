class CreateAccountTypes < ActiveRecord::Migration
  def self.up
    create_table :account_types do |t|
      t.column "name",  :string, :limit => 100
      t.column "title", :string, :limit => 100
    end
  end

  def self.down
    drop_table :account_types
  end
end
