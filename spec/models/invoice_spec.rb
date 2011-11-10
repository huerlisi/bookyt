require 'spec_helper'

describe Invoice do
  it { should belong_to(:customer) }
  it { should belong_to(:company) }

  it { should validate_presence_of(:customer) }
  it { should validate_presence_of(:company) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:state) }

  context "when new" do
    specify { should_not be_valid }

    its(:to_s) { should == "" }
  end

  context "when amount is nil" do
    before(:all) { subject.amount = nil }

    its(:to_s) { should == "" }
  end

  context "when properly initialized" do
    subject { Factory.build :invoice }

    its(:to_s) { should =~ /New Invoice/ }
  end

  context "with bookings" do
    it { should have_many(:bookings) }
  end
end
