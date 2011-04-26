class AttachmentsController < AuthorizedController
  belongs_to :invoice, :polymorphic => true, :optional => true
  belongs_to :employee, :polymorphic => true, :optional => true
  belongs_to :company, :polymorphic => true, :optional => true
end
