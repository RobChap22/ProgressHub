require 'test_helper'

class UserProjectsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get user_projects_show_url
    assert_response :success
  end

end
