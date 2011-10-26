class AttachmentsController < AuthorizedController
  belongs_to :invoice, :polymorphic => true, :optional => true
  belongs_to :employee, :polymorphic => true, :optional => true
  belongs_to :company, :polymorphic => true, :optional => true
  belongs_to :customer, :polymorphic => true, :optional => true
  belongs_to :person, :polymorphic => true, :optional => true
  belongs_to :tenant, :polymorphic => true, :optional => true

  def create
    create! {
      redirect_to :back
      return
    }
  end
end
