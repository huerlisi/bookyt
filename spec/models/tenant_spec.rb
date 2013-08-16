require 'spec_helper'

describe Tenant do
  it { should belong_to :company }

  context "on update" do
    subject { FactoryGirl.create :tenant }

    it { should validate_presence_of :company }
    pending { should validate_date :incorporated_on } # TODO: This validations can be checked at the moment
  end

  context "when new" do
    its(:to_s) { should == "" }
  end

  context "when properly initialized" do
    subject { FactoryGirl.build :tenant }

    its(:to_s) { should =~ /Muster Peter/ }
  end
end
