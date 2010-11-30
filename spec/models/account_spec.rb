require 'spec_helper'

describe Account do
  context "when new" do
    specify { should_not be_valid }
    its(:to_s) { should == " ()" }
  end

  context "when valid" do
    subject { Factory.create :account }
    specify { should be_valid }

    it "should loose validity without code" do
      subject.code = nil
      subject.should_not be_valid
    end
    it "should loose validity without title" do
      subject.title = nil
      subject.should_not be_valid
    end
  end
end
