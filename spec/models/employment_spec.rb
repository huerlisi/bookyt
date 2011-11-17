require 'spec_helper'

describe Employment do
  [:employee, :employer].each do |attr|
    it { should belong_to(attr) }
    it { should validate_presence_of(attr) }
  end

  before(:all) do
    Factory.create(:employment)
  end

  context "class methods" do
    it "returns the current" do
      Employment.current.should_not be_nil
    end
  end
  
  context "when new" do
    its(:to_s) { should eq(' bei  von  - ') }
  end
end