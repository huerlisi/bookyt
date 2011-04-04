class AttachmentsController < AuthorizedController
  belongs_to :invoice, :polymorphic => true, :optional => true
end
