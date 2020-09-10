require 'test_helper'

class LeasingManagersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @leasing_manager = leasing_managers(:one)
  end

  test "should get index" do
    get leasing_managers_url
    assert_response :success
  end

  test "should get new" do
    get new_leasing_manager_url
    assert_response :success
  end

  test "should create leasing_manager" do
    assert_difference('LeasingManager.count') do
      post leasing_managers_url, params: { leasing_manager: { email: @leasing_manager.email, name: @leasing_manager.name, phone: @leasing_manager.phone, project_id: @leasing_manager.project_id } }
    end

    assert_redirected_to leasing_manager_url(LeasingManager.last)
  end

  test "should show leasing_manager" do
    get leasing_manager_url(@leasing_manager)
    assert_response :success
  end

  test "should get edit" do
    get edit_leasing_manager_url(@leasing_manager)
    assert_response :success
  end

  test "should update leasing_manager" do
    patch leasing_manager_url(@leasing_manager), params: { leasing_manager: { email: @leasing_manager.email, name: @leasing_manager.name, phone: @leasing_manager.phone, project_id: @leasing_manager.project_id } }
    assert_redirected_to leasing_manager_url(@leasing_manager)
  end

  test "should destroy leasing_manager" do
    assert_difference('LeasingManager.count', -1) do
      delete leasing_manager_url(@leasing_manager)
    end

    assert_redirected_to leasing_managers_url
  end
end
