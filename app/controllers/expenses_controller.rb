class ExpensesController < ApplicationController
  def new
    @booking = Booking.new(
      :debit_account => Account.find_by_code('1000')
    )

    @vat_booking = Booking.new(
      :title => "MwSt. 8%",
      :debit_account => Account.find_by_code('1000'),
      :credit_account => Account.find_by_code('1170')
    )
  end

  def create
    @booking = Booking.new(params[:booking])
    @vat_booking = Booking.new(params[:vat_booking])

    # Use same debit_account for vat bookings
    @vat_booking.value_date = @booking.value_date
    @vat_booking.debit_account = @booking.debit_account

    if @booking.valid? && @vat_booking.valid?
      @booking.save && @vat_booking.save
      redirect_to "/expenses/new"
    else
      raise @vat_booking.errors.inspect
      render :action => 'new'
    end
  end
end
