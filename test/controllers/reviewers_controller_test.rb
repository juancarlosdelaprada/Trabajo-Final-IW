require 'test_helper'

class ReviewersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get reviewers_new_url
    assert_response :success
  end

  test "should get create" do
    get reviewers_create_url
    assert_response :success
  end

end
