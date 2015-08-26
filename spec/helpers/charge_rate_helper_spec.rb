require 'spec_helper'

describe ChargeRateHelper do
  before do
    FactoryGirl.create(:charge_rate)
  end
  describe "#codes_as_collection" do
    it "returns code collection" do
      expect(helper.codes_as_collection).not_to be_nil
      expect(helper.codes_as_collection).not_to be_empty
      expect(helper.codes_as_collection.first).to eq(["Title (Muster Peter)", "MyString"])
    end
  end
end