# encoding: utf-8

class AttachmentUploader < CarrierWave::Uploader::Base
  # Choose what kind of storage to use for this uploader:
  storage :file

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    root.join(model.class.to_s.underscore, mounted_as.to_s, model.id.to_s)
  end
end
