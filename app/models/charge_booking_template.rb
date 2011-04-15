class ChargeBookingTemplate < BookingTemplate
  # Charge Rates
  def charge_rate(date = nil)
    ChargeRate.current(charge_rate_code, date)
  end
  
  def amount(date = nil)
    return 0.0 unless charge_rate(date)
    
    charge_rate(date).rate / 100
  end
  
  def booking_parameters(params = {})
    # Prepare parameters set by template
    booking_params = attributes.reject!{|key, value| !["title", "comments", "credit_account_id", "debit_account_id"].include?(key)}

    if ref_type = params['reference_type'] and ref_id = params['reference_id']
      reference = ref_type.constantize.find(ref_id)

      # Calculate amount
      booking_params['value_date'] = reference.value_date
      booking_amount = self.amount(reference.value_date)

      case self.amount_relates_to
        when 'reference_amount'
          booking_amount *= reference.amount
        when 'reference_balance'
          booking_amount *= reference.balance
        when 'reference_amount_minus_balance'
          booking_amount *= reference.amount - reference.balance
      end
    end

    booking_amount = booking_amount.round(2)
    booking_params['amount'] = booking_amount
    
    # Override by passed in parameters
    booking_params.merge!(params)
  end
end
