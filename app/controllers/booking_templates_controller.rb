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
end
