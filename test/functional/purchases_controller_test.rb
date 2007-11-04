require File.dirname(__FILE__) + '/../test_helper'
require 'purchases_controller'

# Re-raise errors caught by the controller.
class PurchasesController; def rescue_action(e) raise e end; end

class PurchasesControllerTest < Test::Unit::TestCase
  def setup
    @controller = PurchasesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
