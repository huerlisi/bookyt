class Attachment < ActiveRecord::Base
  # Association
  belongs_to :object, :polymorphic => true
  
  # Carrier Wave
  mount_uploader :file, AttachmentUploader
end
