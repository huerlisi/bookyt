class Mt940Attachment < Attachment
  # MT940 Import
  has_many :mt940_imports

  def content
    File.read(file.current_path, :encoding => self.encoding)
  end
end
