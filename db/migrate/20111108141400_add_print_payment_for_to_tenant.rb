class AddPrintPaymentForToTenant < ActiveRecord::Migration
  def change
    add_column :tenants, :print_payment_for, :boolean
  end
end
