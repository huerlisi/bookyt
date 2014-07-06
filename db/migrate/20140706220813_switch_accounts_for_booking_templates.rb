class SwitchAccountsForBookingTemplates < ActiveRecord::Migration
  def up
    BookingTemplate.find_each do |template|
      template.debit_account, template.credit_account = template.credit_account, template.debit_account
      template.save!
    end
  end

  def down
    BookingTemplate.find_each do |template|
      template.debit_account, template.credit_account = template.credit_account, template.debit_account
      template.save!
    end
  end
end
