class BookingTemplatesController < AuthorizedController
  # Actions
  def index
    order_by = params[:order] || 'title'
    @booking_templates = BookingTemplate.paginate :page => params[:page], :per_page => 100, :order => order_by
    index!
  end
end
