require 'test_helper'

class DayTest < ActiveSupport::TestCase
  setup do
    @day = Day.new(:date => Date.parse('15.2.2010'), :gross_turnover => 100.0, :net_turnover => 80.0)
  end

  should "output sensible string on to_s" do
    assert_equal "15.02.2010: brutto 100.00, netto 80.00", @day.to_s
  end

  context "create_bookings callback" do
    should "be called on save of new object" do
      day = Day.new(:date => Date.parse('15.2.2010'), :gross_turnover => 100.0, :net_turnover => 80.0)
      day.expects(:create_bookings).returns(nil)

      day.save
    end

    should "not be called on second save" do
      day = Day.new(:date => Date.parse('15.2.2010'), :gross_turnover => 100.0, :net_turnover => 80.0)
      day.expects(:create_bookings).returns(nil)

      day.save
      day.save
    end

    should "not be called on update" do
      day = Day.new(:date => Date.parse('15.2.2010'), :gross_turnover => 100.0, :net_turnover => 80.0)
      day.expects(:create_bookings).returns(nil)

      day.save
      day.update_attributes(:net_turnover => 90.0)
    end

    should "create 4 bookings" do
      BookingTemplate.expects(:create_booking).times(4)

      @day.send(:create_bookings)
    end
  end
end
