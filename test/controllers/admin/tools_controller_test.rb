require "test_helper"

class Admin::ToolsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_tools_index_url
    assert_response :success
  end

  test "should get new" do
    get admin_tools_new_url
    assert_response :success
  end

  test "should get edit" do
    get admin_tools_edit_url
    assert_response :success
  end
end
