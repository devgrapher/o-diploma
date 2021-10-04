require "test_helper"

class DiplomasControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get diplomas_index_url
    assert_response :success
  end
end
