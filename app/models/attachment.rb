class Attachment < ActiveRecord::Base
  # Association
  belongs_to :object, :polymorphic => true

  # Carrier Wave
  validates_presence_of :file
  mount_uploader :file, AttachmentUploader

  # String
  def to_s(format = :default)
    title
  end
  
  def self.codes
    [['Brief-Template', 'Prawn::LetterDocument']]
  end
end
