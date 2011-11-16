require 'spec_helper'

describe CivilStatus do
  context "when new" do
    it "to_s returns nothing" do
      civil_status = CivilStatus.new
      civil_status.to_s.should eq('')
    end
  end

  context "when existing" do
    it "to_s returns the title" do
      civil_status = Factory.build(:civil_status)
      civil_status.to_s.should_not be_empty
    end
  end
end
