class BookingTemplatesController < AuthorizedController
  # Actions
  def index
    order_by = params[:order] || 'title'
    @booking_templates = BookingTemplate.paginate :page => params[:page], :per_page => params[:per_page], :order => order_by
    index!
  end

  def create
    create! do |success, failure|
      success.html { redirect_to collection_path }
    end
  end

  def update
    update! do |success, failure|
      success.html { redirect_to collection_path }
    end
  end

  def new_booking
    booking_params = params[:booking] || {}
    booking_params[:value_date] ||= Date.today
    booking_params[:code]       ||= (Booking.maximum(:code) || 0) + 1
    @booking = @booking_template.build_booking(booking_params)

    redirect_to @booking.to_param
  end
end
