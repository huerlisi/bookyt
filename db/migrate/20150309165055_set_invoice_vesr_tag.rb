class SetInvoiceVesrTag < ActiveRecord::Migration
  def up
    return unless BankAccount.tagged_with('invoice:vesr')

    account = BankAccount.find_by_code('1020')
    if account
      account.tag_list << 'invoice:vesr'
      account.save!
      logger.info "Added tag 'invoice:vesr' to Bank Account with code '1020'"
    end
  end
end
