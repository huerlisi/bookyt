require 'test_helper'

class BookingsControllerTest < ActionController::TestCase
  setup do
    @booking = bookings(:first)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bookings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create booking" do
    assert_difference('Booking.count') do
      post :create, :booking => @booking.attributes
    end

    # TODO
    #assert_redirected_to new_booking_path(assigns(:booking))
  end

  test "should show booking" do
    get :show, :id => @booking.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @booking.to_param
    assert_response :success
  end

  test "should update booking" do
    put :update, :id => @booking.to_param, :booking => @booking.attributes
    assert_redirected_to booking_path(assigns(:booking))
  end

  test "should destroy booking" do
    assert_difference('Booking.count', -1) do
      delete :destroy, :id => @booking.to_param
    end

    assert_redirected_to bookings_path
  end
end
