class ChargeBookingTemplate < BookingTemplate
  def booking_parameters(params = {})
    # Prepare parameters set by template
    booking_params = attributes.reject!{|key, value| !["title", "comments", "credit_account_id", "debit_account_id"].include?(key)}

    # Calculate amount
    booking_amount = BigDecimal.new(attributes['amount'] || '0')

    if ref_type = params['reference_type'] and ref_id = params['reference_id']
      reference = ref_type.constantize.find(ref_id)

      case self.amount_relates_to
        when 'reference_amount'
          booking_amount *= reference.amount
        when 'reference_balance'
          booking_amount *= reference.balance
      end
    end

    booking_params['amount'] = booking_amount
    
    # Override by passed in parameters
    booking_params.merge!(params)
  end
end
