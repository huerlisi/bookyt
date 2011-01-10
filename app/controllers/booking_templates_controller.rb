class BookingTemplatesController < AuthorizedController
  # Actions
  def index
    order_by = params[:order] || 'title'
    @booking_templates = BookingTemplate.paginate :page => params[:page], :per_page => params[:per_page], :order => order_by
    index!
  end
end
