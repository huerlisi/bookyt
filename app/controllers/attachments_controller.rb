class AttachmentsController < AuthorizedController
  belongs_to :invoice, :polymorphic => true, :optional => true
  belongs_to :employmee, :polymorphic => true, :optional => true
end
