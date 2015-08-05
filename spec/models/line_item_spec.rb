require 'spec_helper'

describe LineItem do
  it { should belong_to :item }
  it { should belong_to :invoice }
  it { should belong_to :debit_account }
  it { should belong_to :credit_account }

  it { should validate_presence_of(:invoice) }
  it { should validate_presence_of(:times) }
  it { should validate_presence_of(:title) }

  context "bookings" do
    it { should have_one :booking }

    describe "#update_booking" do
      let(:banana) { FactoryGirl.build(:banana) }

      it "should return nil if credit_account is empty" do
        banana.credit_account = nil
        banana.update_booking.should be_nil
      end

      it "should return nil if debit_account is empty" do
        banana.debit_account = nil
        banana.update_booking.should be_nil
      end

      subject { banana.update_booking }
      its(:title) { should == banana.title }
      its(:amount) { should == banana.total_amount }
      its(:credit_account) { should == banana.credit_account }
      its(:debit_account) { should == banana.debit_account }
    end
  end

  context "amounts" do
    describe "blank attributes" do
      subject { LineItem.new }
      its(:total_amount) { should eq(0) }
      its(:times_to_s) { should eq(" x") }
    end

    describe "with x quantity" do
      subject { LineItem.new(:quantity => 'x', :times => 1, :price => 12.25) }
      its(:times) { should eq(1) }
      its(:times_to_s) { should eq('') }
      its(:price) { should eq(12.25) }
      its(:total_amount) { should eq(12.25) }
    end

    describe "with overall quantity" do
      subject { LineItem.new(:quantity => 'overall', :times => 1, :price => 12.25) }
      its(:times) { should eq(1) }
      its(:times_to_s) { should eq(I18n::translate('line_items.quantity.overall')) }
      its(:price) { should eq(12.25) }
      its(:total_amount) { should eq(12.25) }
    end

    describe "without quantity" do
      subject { LineItem.new(:quantity => 'hours', :times => 1.0, :price => 12.25) }
      its(:times) { should eq(1) }
      its(:times_to_s) { should eq("1.0 #{I18n::translate('line_items.quantity.hours')}") }
      its(:price) { should eq(12.25) }
      its(:total_amount) { should eq(12.25) }
    end
  end
end
