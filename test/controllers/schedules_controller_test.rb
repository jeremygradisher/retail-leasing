require 'test_helper'

class SchedulesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @schedule = schedules(:one)
  end

  test "should get index" do
    get schedules_url
    assert_response :success
  end

  test "should get new" do
    get new_schedule_url
    assert_response :success
  end

  test "should create schedule" do
    assert_difference('Schedule.count') do
      post schedules_url, params: { schedule: { area_id: @schedule.area_id, construction_completion_date: @schedule.construction_completion_date, design_duration: @schedule.design_duration, final_plans_received_date: @schedule.final_plans_received_date, final_plans_reviewed_date: @schedule.final_plans_reviewed_date, lease_execution_date: @schedule.lease_execution_date, ll_review_duration: @schedule.ll_review_duration, map_id: @schedule.map_id, merchandising_duration: @schedule.merchandising_duration, mobilization_duration: @schedule.mobilization_duration, open_for_business_date: @schedule.open_for_business_date, permit_received_date: @schedule.permit_received_date, permit_reviewed_duration: @schedule.permit_reviewed_duration, permit_submittal_duration: @schedule.permit_submittal_duration, permit_submitted_date: @schedule.permit_submitted_date, premises_acceptance_date: @schedule.premises_acceptance_date, project_id: @schedule.project_id, tenant_fit_out_duration: @schedule.tenant_fit_out_duration, total_days: @schedule.total_days } }
    end

    assert_redirected_to schedule_url(Schedule.last)
  end

  test "should show schedule" do
    get schedule_url(@schedule)
    assert_response :success
  end

  test "should get edit" do
    get edit_schedule_url(@schedule)
    assert_response :success
  end

  test "should update schedule" do
    patch schedule_url(@schedule), params: { schedule: { area_id: @schedule.area_id, construction_completion_date: @schedule.construction_completion_date, design_duration: @schedule.design_duration, final_plans_received_date: @schedule.final_plans_received_date, final_plans_reviewed_date: @schedule.final_plans_reviewed_date, lease_execution_date: @schedule.lease_execution_date, ll_review_duration: @schedule.ll_review_duration, map_id: @schedule.map_id, merchandising_duration: @schedule.merchandising_duration, mobilization_duration: @schedule.mobilization_duration, open_for_business_date: @schedule.open_for_business_date, permit_received_date: @schedule.permit_received_date, permit_reviewed_duration: @schedule.permit_reviewed_duration, permit_submittal_duration: @schedule.permit_submittal_duration, permit_submitted_date: @schedule.permit_submitted_date, premises_acceptance_date: @schedule.premises_acceptance_date, project_id: @schedule.project_id, tenant_fit_out_duration: @schedule.tenant_fit_out_duration, total_days: @schedule.total_days } }
    assert_redirected_to schedule_url(@schedule)
  end

  test "should destroy schedule" do
    assert_difference('Schedule.count', -1) do
      delete schedule_url(@schedule)
    end

    assert_redirected_to schedules_url
  end
end
