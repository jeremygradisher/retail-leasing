require 'test_helper'

class IconsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @icon = icons(:one)
  end

  test "should get index" do
    get icons_url
    assert_response :success
  end

  test "should get new" do
    get new_icon_url
    assert_response :success
  end

  test "should create icon" do
    assert_difference('Icon.count') do
      post icons_url, params: { icon: { icon: @icon.icon, project_id: @icon.project_id } }
    end

    assert_redirected_to icon_url(Icon.last)
  end

  test "should show icon" do
    get icon_url(@icon)
    assert_response :success
  end

  test "should get edit" do
    get edit_icon_url(@icon)
    assert_response :success
  end

  test "should update icon" do
    patch icon_url(@icon), params: { icon: { icon: @icon.icon, project_id: @icon.project_id } }
    assert_redirected_to icon_url(@icon)
  end

  test "should destroy icon" do
    assert_difference('Icon.count', -1) do
      delete icon_url(@icon)
    end

    assert_redirected_to icons_url
  end
end
