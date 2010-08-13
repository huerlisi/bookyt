require 'test_helper'

class AccountTypesControllerTest < ActionController::TestCase
  setup do
    @account_type = account_types(:first)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:account_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create account_type" do
    assert_difference('AccountType.count') do
      post :create, :account_type => @account_type.attributes
    end

    assert_redirected_to account_type_path(assigns(:account_type))
  end

  test "should show account_type" do
    get :show, :id => @account_type.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @account_type.to_param
    assert_response :success
  end

  test "should update account_type" do
    put :update, :id => @account_type.to_param, :account_type => @account_type.attributes
    assert_redirected_to account_type_path(assigns(:account_type))
  end

  test "should destroy account_type" do
    assert_difference('AccountType.count', -1) do
      delete :destroy, :id => @account_type.to_param
    end

    assert_redirected_to account_types_path
  end
end
