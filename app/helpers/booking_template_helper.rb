module BookingTemplateHelper
  def amount_relations_as_collection
    relations = ['reference_amount', 'reference_balance', 'reference_amount_minus_balance']
    relations.inject({}) do |result, relation|
      result[t(relation, :scope => 'booking_template.relation')] = relation
      result
    end
  end

  def amount_to_s(booking_template)
    if booking_template.amount_relates_to.present?
      return "%.2f%%" % (booking_template.amount.to_f * 100)
    else
      return currency_fmt(booking_template.amount)
    end
  end
end
