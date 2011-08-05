class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.decimal    :quantity, :precision => 10, :scale => 2
      t.decimal    :price,    :precision => 10, :scale => 2
      t.string     :code
      t.string     :title
      t.string     :description
      t.belongs_to :item, :polymorphic => true
      t.string     :type
      t.belongs_to :invoice

      t.timestamps
    end

    add_index :line_items, [:item_id, :item_type]
    add_index :line_items, :invoice_id
  end
end
