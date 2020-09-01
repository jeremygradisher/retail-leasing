require 'test_helper'

class WorkletterTemplatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @workletter_template = workletter_templates(:one)
  end

  test "should get index" do
    get workletter_templates_url
    assert_response :success
  end

  test "should get new" do
    get new_workletter_template_url
    assert_response :success
  end

  test "should create workletter_template" do
    assert_difference('WorkletterTemplate.count') do
      post workletter_templates_url, params: { workletter_template: { amperage: @workletter_template.amperage, amperage_description: @workletter_template.amperage_description, amperage_typical: @workletter_template.amperage_typical, conduit_size: @workletter_template.conduit_size, conduit_size_description: @workletter_template.conduit_size_description, conduit_size_typical: @workletter_template.conduit_size_typical, demolition: @workletter_template.demolition, demolition_description: @workletter_template.demolition_description, demolition_typical: @workletter_template.demolition_typical, drywall: @workletter_template.drywall, drywall_description: @workletter_template.drywall_description, drywall_typical: @workletter_template.drywall_typical, electrical: @workletter_template.electrical, electrical_description: @workletter_template.electrical_description, electrical_meter: @workletter_template.electrical_meter, electrical_meter_description: @workletter_template.electrical_meter_description, electrical_meter_typical: @workletter_template.electrical_meter_typical, electrical_typical: @workletter_template.electrical_typical, ems: @workletter_template.ems, ems_description: @workletter_template.ems_description, ems_typical: @workletter_template.ems_typical, exhaust: @workletter_template.exhaust, exhaust_description: @workletter_template.exhaust_description, exhaust_typical: @workletter_template.exhaust_typical, fire_alarm: @workletter_template.fire_alarm, fire_alarm_description: @workletter_template.fire_alarm_description, fire_alarm_typical: @workletter_template.fire_alarm_typical, gas: @workletter_template.gas, gas_description: @workletter_template.gas_description, gas_typical: @workletter_template.gas_typical, grease: @workletter_template.grease, grease_description: @workletter_template.grease_description, grease_typical: @workletter_template.grease_typical, insulation: @workletter_template.insulation, insulation_description: @workletter_template.insulation_description, insulation_typical: @workletter_template.insulation_typical, line_set_pathways: @workletter_template.line_set_pathways, line_set_pathways_description: @workletter_template.line_set_pathways_description, line_set_pathways_typical: @workletter_template.line_set_pathways_typical, other: @workletter_template.other, other_description: @workletter_template.other_description, other_typical: @workletter_template.other_typical, project_id: @workletter_template.project_id, sanitary: @workletter_template.sanitary, sanitary_description: @workletter_template.sanitary_description, sanitary_typical: @workletter_template.sanitary_typical, sanitary_vent: @workletter_template.sanitary_vent, sanitary_vent_description: @workletter_template.sanitary_vent_description, sanitary_vent_typical: @workletter_template.sanitary_vent_typical, service_door: @workletter_template.service_door, service_door_description: @workletter_template.service_door_description, service_door_typical: @workletter_template.service_door_typical, slab: @workletter_template.slab, slab_description: @workletter_template.slab_description, slab_typical: @workletter_template.slab_typical, sprinkler_grid: @workletter_template.sprinkler_grid, sprinkler_grid_description: @workletter_template.sprinkler_grid_description, sprinkler_grid_typical: @workletter_template.sprinkler_grid_typical, sprinkler_stub: @workletter_template.sprinkler_stub, sprinkler_stub_description: @workletter_template.sprinkler_stub_description, sprinkler_stub_typical: @workletter_template.sprinkler_stub_typical, storefront: @workletter_template.storefront, storefront_description: @workletter_template.storefront_description, storefront_typical: @workletter_template.storefront_typical, structure: @workletter_template.structure, structure_description: @workletter_template.structure_description, structure_typical: @workletter_template.structure_typical, studs: @workletter_template.studs, studs_description: @workletter_template.studs_description, studs_typical: @workletter_template.studs_typical, supply: @workletter_template.supply, supply_description: @workletter_template.supply_description, supply_typical: @workletter_template.supply_typical, telephone: @workletter_template.telephone, telephone_description: @workletter_template.telephone_description, telephone_typical: @workletter_template.telephone_typical, template_name: @workletter_template.template_name, unit: @workletter_template.unit, unit_description: @workletter_template.unit_description, unit_typical: @workletter_template.unit_typical, voltage: @workletter_template.voltage, voltage_description: @workletter_template.voltage_description, voltage_typical: @workletter_template.voltage_typical, water: @workletter_template.water, water_description: @workletter_template.water_description, water_typical: @workletter_template.water_typical } }
    end

    assert_redirected_to workletter_template_url(WorkletterTemplate.last)
  end

  test "should show workletter_template" do
    get workletter_template_url(@workletter_template)
    assert_response :success
  end

  test "should get edit" do
    get edit_workletter_template_url(@workletter_template)
    assert_response :success
  end

  test "should update workletter_template" do
    patch workletter_template_url(@workletter_template), params: { workletter_template: { amperage: @workletter_template.amperage, amperage_description: @workletter_template.amperage_description, amperage_typical: @workletter_template.amperage_typical, conduit_size: @workletter_template.conduit_size, conduit_size_description: @workletter_template.conduit_size_description, conduit_size_typical: @workletter_template.conduit_size_typical, demolition: @workletter_template.demolition, demolition_description: @workletter_template.demolition_description, demolition_typical: @workletter_template.demolition_typical, drywall: @workletter_template.drywall, drywall_description: @workletter_template.drywall_description, drywall_typical: @workletter_template.drywall_typical, electrical: @workletter_template.electrical, electrical_description: @workletter_template.electrical_description, electrical_meter: @workletter_template.electrical_meter, electrical_meter_description: @workletter_template.electrical_meter_description, electrical_meter_typical: @workletter_template.electrical_meter_typical, electrical_typical: @workletter_template.electrical_typical, ems: @workletter_template.ems, ems_description: @workletter_template.ems_description, ems_typical: @workletter_template.ems_typical, exhaust: @workletter_template.exhaust, exhaust_description: @workletter_template.exhaust_description, exhaust_typical: @workletter_template.exhaust_typical, fire_alarm: @workletter_template.fire_alarm, fire_alarm_description: @workletter_template.fire_alarm_description, fire_alarm_typical: @workletter_template.fire_alarm_typical, gas: @workletter_template.gas, gas_description: @workletter_template.gas_description, gas_typical: @workletter_template.gas_typical, grease: @workletter_template.grease, grease_description: @workletter_template.grease_description, grease_typical: @workletter_template.grease_typical, insulation: @workletter_template.insulation, insulation_description: @workletter_template.insulation_description, insulation_typical: @workletter_template.insulation_typical, line_set_pathways: @workletter_template.line_set_pathways, line_set_pathways_description: @workletter_template.line_set_pathways_description, line_set_pathways_typical: @workletter_template.line_set_pathways_typical, other: @workletter_template.other, other_description: @workletter_template.other_description, other_typical: @workletter_template.other_typical, project_id: @workletter_template.project_id, sanitary: @workletter_template.sanitary, sanitary_description: @workletter_template.sanitary_description, sanitary_typical: @workletter_template.sanitary_typical, sanitary_vent: @workletter_template.sanitary_vent, sanitary_vent_description: @workletter_template.sanitary_vent_description, sanitary_vent_typical: @workletter_template.sanitary_vent_typical, service_door: @workletter_template.service_door, service_door_description: @workletter_template.service_door_description, service_door_typical: @workletter_template.service_door_typical, slab: @workletter_template.slab, slab_description: @workletter_template.slab_description, slab_typical: @workletter_template.slab_typical, sprinkler_grid: @workletter_template.sprinkler_grid, sprinkler_grid_description: @workletter_template.sprinkler_grid_description, sprinkler_grid_typical: @workletter_template.sprinkler_grid_typical, sprinkler_stub: @workletter_template.sprinkler_stub, sprinkler_stub_description: @workletter_template.sprinkler_stub_description, sprinkler_stub_typical: @workletter_template.sprinkler_stub_typical, storefront: @workletter_template.storefront, storefront_description: @workletter_template.storefront_description, storefront_typical: @workletter_template.storefront_typical, structure: @workletter_template.structure, structure_description: @workletter_template.structure_description, structure_typical: @workletter_template.structure_typical, studs: @workletter_template.studs, studs_description: @workletter_template.studs_description, studs_typical: @workletter_template.studs_typical, supply: @workletter_template.supply, supply_description: @workletter_template.supply_description, supply_typical: @workletter_template.supply_typical, telephone: @workletter_template.telephone, telephone_description: @workletter_template.telephone_description, telephone_typical: @workletter_template.telephone_typical, template_name: @workletter_template.template_name, unit: @workletter_template.unit, unit_description: @workletter_template.unit_description, unit_typical: @workletter_template.unit_typical, voltage: @workletter_template.voltage, voltage_description: @workletter_template.voltage_description, voltage_typical: @workletter_template.voltage_typical, water: @workletter_template.water, water_description: @workletter_template.water_description, water_typical: @workletter_template.water_typical } }
    assert_redirected_to workletter_template_url(@workletter_template)
  end

  test "should destroy workletter_template" do
    assert_difference('WorkletterTemplate.count', -1) do
      delete workletter_template_url(@workletter_template)
    end

    assert_redirected_to workletter_templates_url
  end
end
