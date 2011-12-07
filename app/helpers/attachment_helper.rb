module AttachmentHelper
  def attachment_code_collection
    t('activerecord.attributes.attachment.code_enum').invert
  end
end
