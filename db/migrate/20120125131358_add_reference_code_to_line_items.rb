class AddReferenceCodeToLineItems < ActiveRecord::Migration
  def change
    add_column :line_items, :reference_code, :string

  end
end
