require 'spec_helper'

describe Attachment do
  it { should belong_to(:object) }

  it { should validate_presence_of(:file) }

  context "when new" do
    specify { should_not be_valid }

    its(:to_s) { should == "" }
  end

  context "when file is nil" do
    before(:all) { subject.file = nil }

    its(:to_s) { should == "" }
  end

  context "when properly initialized" do
    subject { Factory.build :attachment }

    its(:to_s) { should =~ /MyString/ }
  end
end
