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
    # Only include base class records
    @booking_templates = BookingTemplate.where(:type => [nil, 'BookingTemplate']).where("NOT(code LIKE '%:%')").paginate(:page => params[:page])
    new!
  end

  def select_booking
    @booking = Booking.find(params[:id]).dup

    # Clear reference
    @booking.reference  = nil

    increment_booking_code
    # Take value date from form
    @booking.value_date = params[:booking][:value_date]

    render :action => 'simple_edit'
  end

  def select
    @booking = Booking.new(params[:booking])
    increment_booking_code
    @booking_templates = BookingTemplate.where(:type => [nil, 'BookingTemplate']).where("NOT(code LIKE '%:%')").paginate(:page => params[:page])
    @bookings = Booking.where("title LIKE ?", '%' + @booking.title + '%').order('value_date DESC').paginate(:page => params[:page])
  end

  def create
    @booking = Booking.new(params[:booking])

    create! do |success, failure|
      success.html do
        redirect_to new_booking_path
      end
      failure.html {render 'edit'}
    end
  end

  def copy
    original_booking = Booking.find(params[:id])

    @booking = original_booking.dup

    render 'edit'
  end

  private

  def increment_booking_code
    @booking.code = (Booking.maximum(:code) || 0) + 1
  end
end
