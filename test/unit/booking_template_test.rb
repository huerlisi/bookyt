require 'test_helper'

class BookingTemplateTest < ActiveSupport::TestCase
  setup do
    @template = BookingTemplate.new
  end
  
  test "to_s handles template with value date" do
    @template.value_date = '2010-03-02'
    assert_equal "02.03.2010: ? an ? CHF ?, ? (?)", @template.to_s
    assert_equal "02.03.2010: ? / ? CHF ?", @template.to_s(:short)
  end
    
  test "to_s handles template with comments" do
    @template.comments = "Comment"
    assert_equal "?: ? an ? CHF ?, ? (Comment)", @template.to_s
    assert_equal "?: ? / ? CHF ?", @template.to_s(:short)
  end
    
  test "to_s suppress blanks comments" do
    @template.comments = " "
    assert_equal "?: ? an ? CHF ?, ? (?)", @template.to_s
    assert_equal "?: ? / ? CHF ?", @template.to_s(:short)
  end
  
  test "to_s handles template with amount" do
    @template.amount = "77.3"
    assert_equal "?: ? an ? CHF 77.30, ? (?)", @template.to_s
    assert_equal "?: ? / ? CHF 77.30", @template.to_s(:short)
  end

  test "validates date format of value_date" do
    @template.value_date = "2010-02-03"
    assert @template.save

    @template.value_date = "2010-02-30"
    assert !@template.save
    assert !@template.errors.empty?
  end

  test "builds booking" do
    booking_params = {:value_date => "2001-02-03", :amount => 10.0}
    booking = booking_templates(:partial).build_booking(booking_params)
    
    assert_instance_of Booking, booking

    expected = bookings(:first)
    assert_similar expected, booking

    expected.comments = "New comment"
    assert_similar expected, booking_templates(:partial).build_booking(booking_params.merge({:comments => "New comment"}))
  end

  test "build_booking returns new record" do
    assert booking_templates(:partial).build_booking.new_record?
  end
  
  test "build_booking accepts nil" do
    assert_instance_of Booking, booking_templates(:partial).build_booking()
  end

  test "build_booking accepts hash" do
    assert_instance_of Booking, booking_templates(:partial).build_booking({:amount => 77})
  end

  test "build_booking accepts parameters" do
    assert_instance_of Booking, booking_templates(:partial).build_booking(:amount => 77)
  end

  test "create_booking returns persisted record when valid" do
    assert booking_templates(:full).create_booking.persisted?
  end
  
  test "create_booking returns new record when invalid" do
    assert booking_templates(:partial).create_booking.new_record?
  end
  
  test "create_booking accepts hash" do
    assert_instance_of Booking, booking_templates(:partial).create_booking({:amount => 77})
  end

  test "create_booking accepts parameters" do
    assert_instance_of Booking, booking_templates(:partial).create_booking(:amount => 77)
  end

  test "class build_booking returns nil if no template with this code" do
    assert_nil BookingTemplate.create_booking("unreal", {:amount => 77})
  end

  test "class build_booking does lookup by code and build" do
    assert_instance_of Booking, BookingTemplate.create_booking("partial", {:amount => 77})
  end
end
