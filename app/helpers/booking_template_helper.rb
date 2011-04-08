module BookingTemplateHelper
  def amount_relations_as_collection
    relations = ['reference_amount', 'reference_balance']
    relations.inject({}) do |result, relation|
      result[t(relation, :scope => 'booking_template.relation')] = relation
      result
    end
  end
end
