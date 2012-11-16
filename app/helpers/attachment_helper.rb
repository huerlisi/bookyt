module AttachmentHelper
  def attachment_code_collection
    t('activerecord.attributes.attachment.code_enum').invert
  end

  def encoding_collection
    t('activerecord.attributes.attachment.encoding_enum').invert
  end
end
