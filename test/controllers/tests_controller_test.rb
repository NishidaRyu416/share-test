require 'test_helper'

class TestsControllerTest < ActionController::TestCase
  test "should get start" do
    get :start
    assert_response :success
  end

  test "should get question" do
    get :question
    assert_response :success
  end

  test "should get result" do
    get :result
    assert_response :success
  end

end
