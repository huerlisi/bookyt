class SalaryShouldUseRelativeAmount < ActiveRecord::Migration
  def self.up
    salary_invoice = BookingTemplate.find_by_code('salary:invoice')
    salary_invoice.relates_to = 'reference_amount_minus_balance'
    salary_invoice.amount = 1
    salary_invoice.save
  end

  def self.down
  end
end
