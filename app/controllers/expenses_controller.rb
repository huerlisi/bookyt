class ExpensesController < ApplicationController
  def new
    @booking = Booking.new
  end

  def new_vat
    @booking = Booking.new(params[:booking])
    increment_booking_code

    # Guard to ensure all needed fields are filled in
    if @booking.title.blank? or @booking.amount.blank?
      @booking.valid?
      render :action => 'new'
      return
    end

    @booking.debit_account = Account.find_by_code('1000')

    if current_tenant.vat_obligation?
      # Calculate VAT bookings
      @vat_full_rate = ChargeRate.current('vat:full', @booking.value_date)
      @vat_full_booking = Booking.new(
        :title => @booking.title,
        :comments => @vat_full_rate.to_s,
        :amount => (@booking.amount * (@vat_full_rate.rate) / (100 + @vat_full_rate.rate)).round(2),
        :debit_account => Account.find_by_code('1000'),
        :credit_account => Account.find_by_code('1170')
      )
      @vat_reduced_rate = ChargeRate.current('vat:reduced', @booking.value_date)
      @vat_reduced_booking = Booking.new(
        :title => @booking.title,
        :comments => @vat_reduced_rate.to_s,
        :amount => 0,
        :debit_account => Account.find_by_code('1000'),
        :credit_account => Account.find_by_code('1170')
      )
      @vat_special_rate = ChargeRate.current('vat:special', @booking.value_date)
      @vat_special_booking = Booking.new(
        :title => @booking.title,
        :comments => @vat_special_rate.to_s,
        :amount => 0,
        :debit_account => Account.find_by_code('1000'),
        :credit_account => Account.find_by_code('1170')
      )
    end
  end

  def create
    @booking = Booking.new(params[:booking])

    if current_tenant.vat_obligation?
      @vat_full_booking = Booking.new(params[:vat_full_booking])
      @vat_reduced_booking = Booking.new(params[:vat_reduced_booking])
      @vat_special_booking = Booking.new(params[:vat_special_booking])

      # Discount vat amounts from brutto amount
      net_amount = @booking.amount - @vat_full_booking.amount - @vat_reduced_booking.amount - @vat_special_booking.amount
      @booking.amount = net_amount

      # Use same debit_account for vat bookings
      @vat_full_booking.value_date = @booking.value_date
      @vat_full_booking.debit_account = @booking.debit_account
      @vat_reduced_booking.value_date = @booking.value_date
      @vat_reduced_booking.debit_account = @booking.debit_account
      @vat_special_booking.value_date = @booking.value_date
      @vat_special_booking.debit_account = @booking.debit_account
    end

    if @booking.valid? && (!current_tenant.vat_obligation? || (@vat_full_booking.valid? && @vat_reduced_booking.valid? && @vat_special_booking.valid?))
      @booking.save

      if current_tenant.vat_obligation?
        # Only save vat bookings if they have an amount <> 0
        @vat_full_booking.save unless @vat_full_booking.amount == 0
        @vat_reduced_booking.save unless @vat_reduced_booking.amount == 0
        @vat_special_booking.save unless @vat_special_booking.amount == 0
      end

      flash[:notice] = t('flash.actions.create.notice', :resource_name => t('activerecord.models.expense'))
      redirect_to new_expense_path
    else
      render :action => 'new_vat'
    end
  end

  private

  def increment_booking_code
    @booking.code = (Booking.maximum(:code) || 0) + 1
  end
end
