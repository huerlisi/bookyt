require 'spec_helper'

describe ChargeRateHelper do
  before do
    Factory.create(:charge_rate)
  end
  describe "#codes_as_collection" do
    it "returns code collection" do
      helper.codes_as_collection.should_not be_nil
      helper.codes_as_collection.should_not be_empty
      helper.codes_as_collection.first.should eq(["Title (Muster Peter)", "MyString"])
    end
  end
end