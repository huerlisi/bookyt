class Mt940ImportsController < AuthorizedController
  belongs_to :mt940_attachment, :optional => true

  before_filter :only => :new do
    resource.parse
  end
end
