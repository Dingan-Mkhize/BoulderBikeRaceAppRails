require "test_helper"

class PhotosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get photos_url
    assert_response :success
  end
end
