class Attachment < ActiveRecord::Base
  # Association
  belongs_to :object, :polymorphic => true

  # Carrier Wave
  validates_presence_of :file
  mount_uploader :file, AttachmentUploader

  # String
  def to_s(format = :default)
    title == nil ? "" : title
  end
  
  def self.codes
    [['Brief-Template', 'Prawn::LetterDocument']]
  end
  
  before_save :create_title
  private
  def create_title
    self.title = file.filename if title.blank?
  end
end
