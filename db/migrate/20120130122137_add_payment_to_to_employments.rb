class AddPaymentToToEmployments < ActiveRecord::Migration
  def change
    add_column :employments, :payment_to, :text

  end
end
