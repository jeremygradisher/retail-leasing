require 'test_helper'

class PrimaryDealsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @primary_deal = primary_deals(:one)
  end

  test "should get index" do
    get primary_deals_url
    assert_response :success
  end

  test "should get new" do
    get new_primary_deal_url
    assert_response :success
  end

  test "should create primary_deal" do
    assert_difference('PrimaryDeal.count') do
      post primary_deals_url, params: { primary_deal: { area_id: @primary_deal.area_id, deal_id: @primary_deal.deal_id, project_id: @primary_deal.project_id } }
    end

    assert_redirected_to primary_deal_url(PrimaryDeal.last)
  end

  test "should show primary_deal" do
    get primary_deal_url(@primary_deal)
    assert_response :success
  end

  test "should get edit" do
    get edit_primary_deal_url(@primary_deal)
    assert_response :success
  end

  test "should update primary_deal" do
    patch primary_deal_url(@primary_deal), params: { primary_deal: { area_id: @primary_deal.area_id, deal_id: @primary_deal.deal_id, project_id: @primary_deal.project_id } }
    assert_redirected_to primary_deal_url(@primary_deal)
  end

  test "should destroy primary_deal" do
    assert_difference('PrimaryDeal.count', -1) do
      delete primary_deal_url(@primary_deal)
    end

    assert_redirected_to primary_deals_url
  end
end
