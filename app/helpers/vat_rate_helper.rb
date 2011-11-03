module VatRateHelper
  def vat_rates_as_collection
    vats = ChargeRate.where("code LIKE 'vat:%'").latest

    vats.inject({}) do |result, item|
      result[item.rate_to_s] = item.code
      result
    end
  end
end
