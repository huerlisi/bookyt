module BookingHelper
  def reference_types_as_collection
    # TODO: Stock model should be available too, from bookyt_stock
    types = [Invoice]
    types.inject({}) do |result, type|
      result[t_model(type)] = type.base_class
      result
    end
  end
end
