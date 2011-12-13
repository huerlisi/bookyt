class ChargeBookingTemplate < BookingTemplate
  # Charge Rates
  def charge_rate(date = nil, params = {})
    ChargeRate.by_person(params[:person_id]).current(charge_rate_code, date)
  end

  def amount(date = nil, params = {})
    rate = charge_rate(date, params)
    return 0.0 unless rate

    if self.amount_relates_to.present?
      return rate.rate / 100
    else
      return rate.rate
    end
  end

  def xbooking_parameters(params = {})
    # Prepare parameters set by template
    booking_params = attributes.reject!{|key, value| !["title", "comments", "credit_account_id", "debit_account_id"].include?(key)}

    # Calculate amount
    booking_amount = BigDecimal.new(attributes['amount'] || '0')

    params.stringify_keys!

    # Lookup reference
    reference = params['reference']
    unless reference
      ref_type = params['reference_type']
      ref_id = params['reference_id']
      if ref_type.present? and ref_id.present?
        reference = ref_type.constantize.find(ref_id)
      end
    end

    if reference
      # Calculate amount
      booking_params['value_date'] = reference.value_date
      booking_amount = self.amount(reference.value_date, :person_id => person_id)

      case self.amount_relates_to
        when 'reference_amount'
          booking_amount *= reference.amount
        when 'reference_balance'
          booking_amount *= reference.balance
        when 'reference_amount_minus_balance'
          booking_amount *= reference.amount - reference.balance
      end
    end

    booking_amount = booking_amount.try(:round, 2)
    booking_params['amount'] = booking_amount

    # Override by passed in parameters
    HashWithIndifferentAccess.new(booking_params.merge!(params))
  end
end
