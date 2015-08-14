require 'spec_helper'

describe Attachment do
  it { should belong_to(:reference) }

  it { should validate_presence_of(:file) }

  context "when new" do
    specify { should_not be_valid }

    its(:to_s) { should == "Anhang ()" }
  end

  context "when file is nil" do
    before { subject.file = nil }

    its(:to_s) { should == "Anhang ()" }
  end

  context "when properly initialized" do
    subject { FactoryGirl.build :attachment }

    its(:to_s) { should =~ /MyString/ }
  end
end
