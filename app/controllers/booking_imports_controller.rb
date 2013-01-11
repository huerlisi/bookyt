class BookingImportsController < AuthorizedController
  before_filter :only => [:new, :edit, :show] do
    resource.parse
  end
end
