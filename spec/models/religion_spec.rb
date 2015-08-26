require 'spec_helper'

describe Religion do
  context "when new" do
    it "to_s returns nothing" do
      religion = Religion.new
      expect(religion.to_s).to eq('')
    end
  end

  context "when existing" do
    it "to_s returns the title" do
      religion = FactoryGirl.build(:religion)
      expect(religion.to_s).not_to be_empty
    end
  end
end
