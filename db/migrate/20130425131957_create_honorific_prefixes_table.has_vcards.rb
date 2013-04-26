# This migration comes from has_vcards (originally 20121113120000)
class CreateHonorificPrefixesTable < ActiveRecord::Migration
  def up
    create_table "honorific_prefixes" do |t|
      t.integer "sex"
      t.string  "name"
      t.integer "position"
    end
  end
end
