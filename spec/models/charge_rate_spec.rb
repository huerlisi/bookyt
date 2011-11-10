require 'spec_helper'

describe ChargeRate do
  it { should belong_to :person }

  context "when new" do
    it "should return an empty string" do
      @charge_rate = ChargeRate.new

      @charge_rate.to_s.should == ""
      @charge_rate.to_s(:long).should == ""
    end
  end
  
  context "when properly initialized" do
    it "should return as string the title" do
      @charge_rate = Factory.build(:charge_rate)

      @charge_rate.to_s.should == "Title: 9.99"
      @charge_rate.to_s(:long).should == "Title: 9.99 (14.04.2011 - 14.04.2011)"
    end
  end
end
