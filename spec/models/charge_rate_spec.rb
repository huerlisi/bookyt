require 'spec_helper'

describe ChargeRate do
  it { should belong_to :person }
  
  context "when new" do
    its(:to_s) { should == ": " }
  end
  
  context "when properly initialized" do
    subject { Factory.build :charge_rate }

    its(:to_s) { should =~ /Title: 9.99/ }
  end
end
