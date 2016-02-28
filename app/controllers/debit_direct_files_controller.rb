class DebitDirectFilesController < AuthorizedController
  def create
    bank_account = Account.find_by_tag('invoice:vesr')
    @debit_direct_file = DebitDirectFileCreator.call(current_tenant, bank_account)
    redirect_to @debit_direct_file
  end

  def show
    respond_to do |format|
      format.html {}
      format.text do
        send_data @debit_direct_file.content, filename: "debit-direct-#{@debit_direct_file.id}.txt"
      end
    end
  end
end
