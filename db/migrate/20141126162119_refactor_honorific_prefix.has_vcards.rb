# This migration comes from has_vcards (originally 20140619121756)
class RefactorHonorificPrefix < ActiveRecord::Migration
  def change
    drop_table :has_vcards_honorific_prefixes
  end
end
