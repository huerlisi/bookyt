# Saldo Line Item
#
# Specializes LineItem to return saldo
class SaldoLineItem < LineItem
  # String
  def to_s
    "%s: %s (sum of %s)" % [self.title, self.total_amount, self.reference_code]
  end

  # Times getter
  #
  # Hardcoded as 1.
  def times
    1
  end

  # Times as string
  #
  # Is always empty.
  def times_to_s
    ""
  end

  # Accounted amount
  #
  # Simply return total amount, direct_account is not relevant.
  def accounted_amount
    total_amount
  end
end
