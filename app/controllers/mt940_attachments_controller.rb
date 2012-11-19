class Mt940AttachmentsController < AttachmentsController
  defaults :resource_class => Mt940Attachment

  def create
    create! {
      new_mt940_attachment_mt940_import_path(resource)
    }
  end
end
