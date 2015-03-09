class SetInvoiceVesrTag < ActiveRecord::Migration
  def up
    return unless BankAccount.tagged_with('invoice:vesr')

    account = BankAccount.find_by_code('1020')
    account.tag_list << 'invoice:vesr'
    account.save!
  end
end
