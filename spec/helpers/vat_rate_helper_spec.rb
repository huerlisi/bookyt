require 'spec_helper'

describe VatRateHelper do
  before do
    Factory.create(:vat_rate)
  end

  describe "#vat_rates_as_collection" do
    it "returns the VAT rates" do
      helper.vat_rates_as_collection.should eq({"8.7" => "vat:normal"})
    end
  end
end
