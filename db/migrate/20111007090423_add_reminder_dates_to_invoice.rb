class AddReminderDatesToInvoice < ActiveRecord::Migration
  def change
    add_column :invoices, :reminder_due_date, :date
    add_column :invoices, :second_reminder_due_date, :date
    add_column :invoices, :third_reminder_due_date, :date
  end
end
