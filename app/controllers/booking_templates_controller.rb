class BookingTemplatesController < InheritedResources::Base
  def index
    order_by = params[:order] || 'value_date'
    @booking_templates = BookingTemplate.paginate :page => params[:page], :per_page => 100, :order => order_by
    index!
  end
end
