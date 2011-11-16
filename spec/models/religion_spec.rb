require 'spec_helper'

describe Religion do
  context "when new" do
    it "to_s returns nothing" do
      religion = Religion.new
      religion.to_s.should eq('')
    end
  end

  context "when existing" do
    it "to_s returns the title" do
      religion = Factory.build(:religion)
      religion.to_s.should_not be_empty
    end
  end
end
