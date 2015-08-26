require 'spec_helper'

describe Employment do
  [:employee, :employer].each do |attr|
    it { is_expected.to belong_to(attr) }
    it { is_expected.to validate_presence_of(attr) }
  end

  before(:all) do
    FactoryGirl.create(:employment)
  end

  context "class methods" do
    it "returns the current" do
      expect(Employment.current).not_to be_nil
    end
  end

  context "when new" do
    its(:to_s) { should eq(' bei  von  - ') }
  end
end