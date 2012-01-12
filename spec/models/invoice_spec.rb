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
    its(:to_s) { should == "" }
  end

  context "when properly initialized" do
    subject { Factory.build :invoice }

    its(:to_s) { should == '' }
  end

  context "Attachments" do
    it { should have_many(:attachments) }
  end

  context "Bookings" do
    it { should have_many(:bookings) }
  end

  context "line_items" do
    it { should have_many(:line_items) }

    subject { Factory.build(:invoice) }

    it "should be empty for new instance" do
      subject.line_items.should be_empty
    end

    it "should create one booking per line_item" do
      subject.line_items << Factory.build(:banana)
      subject.line_items << Factory.build(:vat)
      puts "PRE-TEST"
      puts subject.bookings.inspect
      subject.save

      subject.bookings.size.should == 2
      puts "TEST"
      puts subject.bookings.inspect
    end

    it "should build booking with value_date of invoice" do
      subject.line_items << Factory.build(:banana)
      subject.line_items << Factory.build(:contracting, :date => '2000-01-01')
      subject.save

      subject.bookings.each do |booking|
        booking.value_date.should == subject.value_date
      end
    end
  end
end
