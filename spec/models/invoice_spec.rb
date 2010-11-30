require 'spec_helper'

describe Invoice do
  context "when new" do
    specify { should_not be_valid }
    its(:to_s) { should == "" }
  end

  context "when valid" do
    subject { Factory.create :invoice }
    specify { should be_valid }
    
    it "should loose validity without customer" do
      subject.customer = nil
      subject.should_not be_valid
    end
    it "should loose validity without company" do
      subject.company = nil
      subject.should_not be_valid
    end
  end
end
