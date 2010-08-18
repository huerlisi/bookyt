require 'test_helper'

class DayTest < ActiveSupport::TestCase
  setup do
    @day = Day.new(:date => Date.parse('15.2.2010'), :gross_turnover => 100.0, :net_turnover => 80.0)
  end

  test "to_s" do
    assert_equal "15.02.2010: brutto 100.00, netto 80.00", @day.to_s
  end

  test "save calls create_bookings" do
    @day.expects(:create_bookings).returns(nil)
    
    @day.save
  end
end
