class SeedAssetBookingTemplates < ActiveRecord::Migration
  def self.up
    # Workaround as we changed BookingTemplate before
    BookingTemplate.reset_column_information

    BookingTemplate.create!([
      {:code => "asset:activate", :title => "Aktivierung", :debit_account => Account.find_by_code("4000"), :credit_account => Account.find_by_code("1230"), :amount => 1, :amount_relates_to => 'reference_amount'},

      {:code => "asset:deprecation", :title => "Abschreibung linear 10%", :debit_account => Account.find_by_code("1230"), :credit_account => Account.find_by_code("6900"), :amount => 0.1, :amount_relates_to => 'reference_amount'},
    ])
  end

  def self.down
  end
end
