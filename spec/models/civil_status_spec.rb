require 'spec_helper'

describe CivilStatus do
  context "when new" do
    it "to_s returns nothing" do
      civil_status = CivilStatus.new
      expect(civil_status.to_s).to eq('')
    end
  end

  context "when existing" do
    it "to_s returns the title" do
      civil_status = FactoryGirl.build(:civil_status)
      expect(civil_status.to_s).not_to be_empty
    end
  end
end
