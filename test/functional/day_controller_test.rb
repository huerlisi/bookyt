require File.dirname(__FILE__) + '/../test_helper'
require 'day_controller'

# Re-raise errors caught by the controller.
class DayController; def rescue_action(e) raise e end; end

class DayControllerTest < Test::Unit::TestCase
  def setup
    @controller = DayController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
