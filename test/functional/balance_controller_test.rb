require File.dirname(__FILE__) + '/../test_helper'
require 'balance_controller'

# Re-raise errors caught by the controller.
class BalanceController; def rescue_action(e) raise e end; end

class BalanceControllerTest < Test::Unit::TestCase
  def setup
    @controller = BalanceController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
