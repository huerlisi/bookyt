class CreateDays < ActiveRecord::Migration
  def self.up
    create_table :days do |t|
      t.column "created_at", :datetime
      t.column "updated_at", :datetime
      t.column "date", :date
      t.column "cash", :float
      t.column "tip", :float
      t.column "cards", :float
      t.column "error", :float
    end
  end

  def self.down
    drop_table :days
  end
end
