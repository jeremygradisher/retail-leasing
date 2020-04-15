require 'test_helper'

class AreasDealsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @areas_deal = areas_deals(:one)
  end

  test "should get index" do
    get areas_deals_url
    assert_response :success
  end

  test "should get new" do
    get new_areas_deal_url
    assert_response :success
  end

  test "should create areas_deal" do
    assert_difference('AreasDeal.count') do
      post areas_deals_url, params: { areas_deal: { area_id: @areas_deal.area_id, deal_id: @areas_deal.deal_id } }
    end

    assert_redirected_to areas_deal_url(AreasDeal.last)
  end

  test "should show areas_deal" do
    get areas_deal_url(@areas_deal)
    assert_response :success
  end

  test "should get edit" do
    get edit_areas_deal_url(@areas_deal)
    assert_response :success
  end

  test "should update areas_deal" do
    patch areas_deal_url(@areas_deal), params: { areas_deal: { area_id: @areas_deal.area_id, deal_id: @areas_deal.deal_id } }
    assert_redirected_to areas_deal_url(@areas_deal)
  end

  test "should destroy areas_deal" do
    assert_difference('AreasDeal.count', -1) do
      delete areas_deal_url(@areas_deal)
    end

    assert_redirected_to areas_deals_url
  end
end
