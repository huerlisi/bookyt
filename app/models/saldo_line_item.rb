class SaldoLineItem < LineItem
  def times
    ""
  end

  def price
    # Guard against missing invoice
    return 0.0 unless invoice
    
    invoice.line_items.select{|item|
      item.include_in_saldo_list.include?(self.quantity)
    }.sum(&:total_amount)
  end

  def total_amount
    price
  end
end
