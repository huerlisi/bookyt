require 'spec_helper'

describe Attachment do
  it { is_expected.to belong_to(:reference) }

  it { is_expected.to validate_presence_of(:file) }

  context "when new" do
    specify { is_expected.not_to be_valid }

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
