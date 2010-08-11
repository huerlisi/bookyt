require 'test_helper'

class BookingTemplatesControllerTest < ActionController::TestCase
  setup do
    @booking_template = booking_templates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:booking_templates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create booking_template" do
    assert_difference('BookingTemplate.count') do
      post :create, :booking_template => @booking_template.attributes
    end

    assert_redirected_to booking_template_path(assigns(:booking_template))
  end

  test "should show booking_template" do
    get :show, :id => @booking_template.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @booking_template.to_param
    assert_response :success
  end

  test "should update booking_template" do
    put :update, :id => @booking_template.to_param, :booking_template => @booking_template.attributes
    assert_redirected_to booking_template_path(assigns(:booking_template))
  end

  test "should destroy booking_template" do
    assert_difference('BookingTemplate.count', -1) do
      delete :destroy, :id => @booking_template.to_param
    end

    assert_redirected_to booking_templates_path
  end
end
