require "test_helper"

class RidersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get riders_index_url
    assert_response :success
  end
end
