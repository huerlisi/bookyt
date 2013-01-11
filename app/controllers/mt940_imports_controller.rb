class Mt940ImportsController < BookingImportsController
  before_filter :only => :new do
    resource.parse
  end
end
