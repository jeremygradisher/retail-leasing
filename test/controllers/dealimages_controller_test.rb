require 'test_helper'

class DealimagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @dealimage = dealimages(:one)
  end

  test "should get index" do
    get dealimages_url
    assert_response :success
  end

  test "should get new" do
    get new_dealimage_url
    assert_response :success
  end

  test "should create dealimage" do
    assert_difference('Dealimage.count') do
      post dealimages_url, params: { dealimage: { deal_id: @dealimage.deal_id, deal_id: @dealimage.deal_id, dealimage: @dealimage.dealimage } }
    end

    assert_redirected_to dealimage_url(Dealimage.last)
  end

  test "should show dealimage" do
    get dealimage_url(@dealimage)
    assert_response :success
  end

  test "should get edit" do
    get edit_dealimage_url(@dealimage)
    assert_response :success
  end

  test "should update dealimage" do
    patch dealimage_url(@dealimage), params: { dealimage: { deal_id: @dealimage.deal_id, deal_id: @dealimage.deal_id, dealimage: @dealimage.dealimage } }
    assert_redirected_to dealimage_url(@dealimage)
  end

  test "should destroy dealimage" do
    assert_difference('Dealimage.count', -1) do
      delete dealimage_url(@dealimage)
    end

    assert_redirected_to dealimages_url
  end
end
