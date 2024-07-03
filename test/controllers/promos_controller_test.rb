require "test_helper"

class PromosControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get promos_new_url
    assert_response :success
  end
end
