require File.dirname(__FILE__) + '/../test_helper'
require 'account_types_controller'

# Re-raise errors caught by the controller.
class AccountTypesController; def rescue_action(e) raise e end; end

class AccountTypesControllerTest < Test::Unit::TestCase
  fixtures :account_types

  def setup
    @controller = AccountTypesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_index
    get :index
    assert_response :success
    assert_template 'list'
  end

  def test_list
    get :list

    assert_response :success
    assert_template 'list'

    assert_not_nil assigns(:account_types)
  end

  def test_show
    get :show, :id => 1

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:account_type)
    assert assigns(:account_type).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:account_type)
  end

  def test_create
    num_account_types = AccountType.count

    post :create, :account_type => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_account_types + 1, AccountType.count
  end

  def test_edit
    get :edit, :id => 1

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:account_type)
    assert assigns(:account_type).valid?
  end

  def test_update
    post :update, :id => 1
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => 1
  end

  def test_destroy
    assert_not_nil AccountType.find(1)

    post :destroy, :id => 1
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      AccountType.find(1)
    }
  end
end
