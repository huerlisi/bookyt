require 'spec_helper'

describe Day do
  context "a closed day" do
    subject { FactoryGirl.build(:closed_day, :gross_turnover => 100.0, :net_turnover => 80.0) }

    its(:to_s) { should == "15.02.2010: brutto 100.00, netto 80.00" }
  end

  context "create_bookings callback" do
    it "be called on save of new object" do
      day = FactoryGirl.build(:day)

      day.should_receive(:create_bookings)
      day.save
    end

    it "not be called on persisted record" do
      day = FactoryGirl.create(:day)

      day.should_receive(:create_bookings).never
      day.save
    end

    it "not be called on update" do
      day = FactoryGirl.create(:day)

      day.should_receive(:create_bookings).never
      day.update_attributes(:net_turnover => 90.0)
    end

    it "create 4 bookings" do
      day = FactoryGirl.build(:day)

      BookingTemplate.should_receive(:create_booking).exactly(4).times
      day.send(:create_bookings)
    end
  end
end
