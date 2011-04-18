module ChargeRateHelper
  def codes_as_collection
    ChargeRate.latest.map{|charge_rate| [charge_rate.title, charge_rate.id]}
  end
end
