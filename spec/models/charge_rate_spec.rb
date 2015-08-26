require 'spec_helper'

describe ChargeRate do
  it { is_expected.to belong_to :person }

  context "when new" do
    it "should return an empty string" do
      @charge_rate = ChargeRate.new

      expect(@charge_rate.to_s).to eq("")
      expect(@charge_rate.to_s(:long)).to eq("")
    end
  end

  context "when properly initialized" do
    it "should return as string the title" do
      @charge_rate = FactoryGirl.build(:charge_rate)

      expect(@charge_rate.to_s).to eq("Title (9.99)")
      expect(@charge_rate.to_s(:long)).to eq("Title: 9.99 (14.04.2011 - )")
    end
  end
end
