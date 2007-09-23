class Float
  def size
    to_s.size
  end

  def strip
    to_s
  end

  def currency_round
    (self * 20).round / 20.0
  end

  def currency_fmt
    sprintf("%.2f", self.currency_round)
  end
end
