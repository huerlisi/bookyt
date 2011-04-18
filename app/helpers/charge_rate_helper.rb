module ChargeRateHelper
  def codes_as_collection
    ChargeRate.latest.map{|charge_rate| ["%s (%s)" % [charge_rate.title, charge_rate.person], charge_rate.code]}
  end
end
