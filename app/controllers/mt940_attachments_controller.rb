class Mt940AttachmentsController < AttachmentsController
  defaults :resource_class => Mt940Attachment

  after_filter :only => :create do
    resource.to_bookings
  end
end
