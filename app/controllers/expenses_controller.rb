class ExpensesController < ApplicationController
  def new
    @booking = Booking.new(
      :debit_account => Account.find_by_code('1000')
    )

    @vat_full_rate = ChargeRate.current('vat:full', Date.today)
    @vat_full_booking = Booking.new(
      :title => @vat_full_rate.title,
      :debit_account => Account.find_by_code('1000'),
      :credit_account => Account.find_by_code('1170')
    )
    @vat_reduced_rate = ChargeRate.current('vat:reduced', Date.today)
    @vat_reduced_booking = Booking.new(
      :title => @vat_reduced_rate.title,
      :debit_account => Account.find_by_code('1000'),
      :credit_account => Account.find_by_code('1170')
    )
    @vat_special_rate = ChargeRate.current('vat:special', Date.today)
    @vat_special_booking = Booking.new(
      :title => @vat_special_rate.title,
      :debit_account => Account.find_by_code('1000'),
      :credit_account => Account.find_by_code('1170')
    )
  end

  def create
    @booking = Booking.new(params[:booking])
    @vat_full_booking = Booking.new(params[:vat_full_booking])
    @vat_reduced_booking = Booking.new(params[:vat_reduced_booking])
    @vat_special_booking = Booking.new(params[:vat_special_booking])

    # Use same debit_account for vat bookings
    @vat_full_booking.value_date = @booking.value_date
    @vat_full_booking.debit_account = @booking.debit_account
    @vat_reduced_booking.value_date = @booking.value_date
    @vat_reduced_booking.debit_account = @booking.debit_account
    @vat_special_booking.value_date = @booking.value_date
    @vat_special_booking.debit_account = @booking.debit_account

    if @booking.valid? && @vat_full_booking.valid? && @vat_reduced_booking.valid? && @vat_special_booking.valid?
      @booking.save && @vat_full_booking.save && @vat_reduced_booking.save && @vat_special_booking.valid?
      redirect_to "/expenses/new"
    else
      render :action => 'new'
    end
  end
end
