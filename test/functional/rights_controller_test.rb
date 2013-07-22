require 'test_helper'

class RightsControllerTest < ActionController::TestCase
  test "should get it_is_allowed?" do
    get :it_is_allowed?
    assert_response :success
  end

end
