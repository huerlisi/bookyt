class UpdateCachedAmounts < ActiveRecord::Migration
  def up
    Invoice.transaction do
      Invoice.find_each do |invoice|
        invoice.update_amount
        invoice.update_due_amount
      end
    end
  end
end
