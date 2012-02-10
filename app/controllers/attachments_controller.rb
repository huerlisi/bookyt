class AttachmentsController < AuthorizedController
  belongs_to :invoice, :polymorphic => true, :optional => true
  belongs_to :debit_invoice, :polymorphic => true, :optional => true
  belongs_to :credit_invoice, :polymorphic => true, :optional => true
  belongs_to :salary, :polymorphic => true, :optional => true
  belongs_to :employee, :polymorphic => true, :optional => true
  belongs_to :company, :polymorphic => true, :optional => true
  belongs_to :customer, :polymorphic => true, :optional => true
  belongs_to :person, :polymorphic => true, :optional => true
  belongs_to :tenant, :polymorphic => true, :optional => true
  belongs_to :account, :polymorphic => true, :optional => true
  belongs_to :bank_account, :polymorphic => true, :optional => true

  def create
    create! {
      redirect_to :back
      return
    }
  end

  def download
    @attachment = Attachment.find(params[:id])

    path = @attachment.file.current_path
    send_file path
  end
end
