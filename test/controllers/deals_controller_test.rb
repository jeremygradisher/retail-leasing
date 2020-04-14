require 'test_helper'

class DealsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @deal = deals(:one)
  end

  test "should get index" do
    get deals_url
    assert_response :success
  end

  test "should get new" do
    get new_deal_url
    assert_response :success
  end

  test "should create deal" do
    assert_difference('Deal.count') do
      post deals_url, params: { deal: { area_id: @deal.area_id, deal_name: @deal.deal_name, gross_area: @deal.gross_area, lease_status: @deal.lease_status, map_id: @deal.map_id, net_rentable_area: @deal.net_rentable_area, project_id: @deal.project_id } }
    end

    assert_redirected_to deal_url(Deal.last)
  end

  test "should show deal" do
    get deal_url(@deal)
    assert_response :success
  end

  test "should get edit" do
    get edit_deal_url(@deal)
    assert_response :success
  end

  test "should update deal" do
    patch deal_url(@deal), params: { deal: { area_id: @deal.area_id, deal_name: @deal.deal_name, gross_area: @deal.gross_area, lease_status: @deal.lease_status, map_id: @deal.map_id, net_rentable_area: @deal.net_rentable_area, project_id: @deal.project_id } }
    assert_redirected_to deal_url(@deal)
  end

  test "should destroy deal" do
    assert_difference('Deal.count', -1) do
      delete deal_url(@deal)
    end

    assert_redirected_to deals_url
  end
end
