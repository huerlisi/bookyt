class BookingsController < AuthorizedController
  # Scopes
  has_scope :by_value_period, :using => [:from, :to], :default => proc { |c| c.session[:has_scope] }
  has_scope :by_text

  # Actions
  def index
    @bookings = apply_scopes(Booking).accessible_by(current_ability, :list).includes(:credit_account, :debit_account).paginate(:page => params[:page], :per_page => params[:per_page])
    index!
  end

  def new
    @booking = Booking.new(:value_date => Date.today)
    new!
  end

  def select_booking
    @booking = Booking.find(params[:id]).clone
    @booking.value_date = params[:booking][:value_date]
    render :action => 'edit'
  end

  def select_booking_template
    @booking_template = BookingTemplate.find(params[:id]).clone
    @booking = @booking_template.build_booking(params[:booking])
    render :action => 'edit'
  end

  def select
    @booking = Booking.new(params[:booking])
    @booking_templates = BookingTemplate.all.paginate(:page => params[:page])
    @bookings = Booking.where("title LIKE ?", '%' + @booking.title + '%').order('value_date DESC').paginate(:page => params[:page])
  end

  def create
    @booking = Booking.new(params[:booking])

    create! do |success, failure|
      success.html {redirect_to new_booking_path(:notice => render_to_string(:partial => 'layouts/flash_new', :locals => {:object => @booking}))}
      failure.html {render 'edit'}
    end
  end

  def copy
    original_booking = Booking.find(params[:id])

    @booking = original_booking.clone

    render 'edit'
  end
end
