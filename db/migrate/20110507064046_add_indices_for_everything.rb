class AddIndicesForEverything < ActiveRecord::Migration
  def self.up
    add_index :account_types, :name

    add_index :accounts, :account_type_id

    add_index :assets, :state
    add_index :assets, :purchase_invoice_id
    add_index :assets, :selling_invoice_id

    add_index :attachments, [:object_id, :object_type]

    add_index :booking_templates, :type
    add_index :booking_templates, :credit_account_id
    add_index :booking_templates, :debit_account_id

    add_index :bookings, :credit_account_id
    add_index :bookings, :debit_account_id
    add_index :bookings, :value_date
    add_index :bookings, [:reference_id, :reference_type]

    add_index :charge_rates, :person_id

    add_index :employments, :employee_id
    add_index :employments, :employer_id

    add_index :roles, :name

    add_index :roles_users, :role_id
    add_index :roles_users, :user_id

    add_index :tenants, :person_id

    add_index :users, :person_id
    add_index :users, :tenant_id

    add_index :people, :type

    add_index :invoices, :type
    add_index :invoices, :value_date
    add_index :invoices, :state
  end

  def self.down
  end
end
