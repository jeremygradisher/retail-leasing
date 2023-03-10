class CreateWorkletters < ActiveRecord::Migration[5.0]
  def change
    create_table :workletters do |t|
      t.string :name
      t.integer :project_id
      t.integer :map_id
      t.integer :ll_count_total
      t.string :slab
      t.string :studs
      t.string :drywall
      t.string :insulation
      t.string :service_door
      t.string :storefront
      t.string :supply
      t.string :exhaust
      t.string :unit
      t.string :line_set_pathways
      t.string :ems
      t.string :voltage
      t.string :amperage
      t.string :conduit_size
      t.string :electrical_meter
      t.string :tele_conduit_size
      t.string :sanitary
      t.string :sanitary_vent
      t.string :grease
      t.string :water
      t.string :gas
      t.string :sprinkler_stub
      t.string :sprinkler_grid
      t.string :fire_alarm
      t.text :slab_description
      t.text :studs_description
      t.text :drywall_description
      t.text :storefront_description
      t.text :servicedoor_description
      t.text :untis_description
      t.text :supplyduct_description
      t.text :exhaustduct_description
      t.text :linesetpathway_description
      t.text :emergency_description
      t.text :voltage_description
      t.text :amperage_description
      t.text :conduitsize_description
      t.text :panels_description
      t.text :meter_description
      t.text :telephone_description
      t.text :sanitary_description
      t.text :sanitaryvent_description
      t.text :grease_description
      t.text :water_description
      t.text :gas_description
      t.text :sprinklerstub_description
      t.text :sprinklergrid_description
      t.text :firealarm_description
      t.text :insulation_description
      t.boolean :slab_complete
      t.boolean :slab_typical
      t.string :slab_date
      t.boolean :studs_typical
      t.boolean :drywall_typical
      t.boolean :insulation_typical
      t.boolean :service_door_typical
      t.boolean :storefront_typical
      t.boolean :supply_duct_typical
      t.boolean :exhaust_duct_typical
      t.boolean :unit_typical
      t.boolean :line_set_pathways_typical
      t.boolean :ems_typical
      t.boolean :voltage_typical
      t.boolean :amperage_typical
      t.boolean :conduit_size_typical
      t.boolean :electrical_meter_typical
      t.boolean :telephone_typical
      t.boolean :sanitary_typical
      t.boolean :sanitary_vent_typical
      t.boolean :grease_typical
      t.boolean :water_typical
      t.boolean :gas_typical
      t.boolean :sprinkler_stub_typical
      t.boolean :sprinkler_grid_typical
      t.boolean :fire_alarm_typical
      t.boolean :studs_complete
      t.boolean :drywall_complete
      t.boolean :insulation_complete
      t.boolean :service_door_complete
      t.boolean :storefront_complete
      t.boolean :supply_duct_complete
      t.boolean :exhaust_duct_complete
      t.boolean :unit_complete
      t.boolean :line_set_pathways_complete
      t.boolean :ems_complete
      t.boolean :voltage_complete
      t.boolean :amperage_complete
      t.boolean :conduit_size_complete
      t.boolean :electrical_meter_complete
      t.boolean :telephone_complete
      t.boolean :sanitary_complete
      t.boolean :sanitary_vent_complete
      t.boolean :grease_complete
      t.boolean :water_complete
      t.boolean :gas_complete
      t.boolean :sprinkler_stub_complete
      t.boolean :sprinkler_grid_complete
      t.boolean :fire_alarm_complete
      t.string :studs_date
      t.string :drywall_date
      t.string :insulation_date
      t.string :service_door_date
      t.string :storefront_date
      t.string :supply_date
      t.string :exhaust_date
      t.string :unit_date
      t.string :line_set_pathways_date
      t.string :ems_date
      t.string :voltage_date
      t.string :amperage_date
      t.string :conduit_size_date
      t.string :electrical_meter_date
      t.string :tele_conduit_size_date
      t.string :sanitary_date
      t.string :grease_date
      t.string :water_date
      t.string :sprinkler_stub_date
      t.string :sprinkler_grid_date
      t.string :fire_alarm_date
      t.string :gas_date
      t.string :sanitary_vent_date
      t.string :electrical
      t.text :electrical_description
      t.boolean :electrical_typical
      t.string :electrical_responsibility
      t.boolean :electrical_complete
      t.string :electrical_date
      t.float :ll_work
      t.float :ll_work_cost
      t.float :slab_cost
      t.float :studs_cost
      t.float :drywall_cost
      t.float :insulation_cost
      t.float :service_door_cost
      t.float :storefront_cost
      t.float :supply_cost
      t.float :exhaust_cost
      t.float :unit_cost
      t.float :ems_cost
      t.float :voltage_cost
      t.float :amperage_cost
      t.float :conduit_size_cost
      t.float :electrical_cost
      t.float :electrical_meter_cost
      t.float :telephone_cost
      t.float :sanitary_cost
      t.float :sanitary_vent_cost
      t.float :grease_cost
      t.float :water_cost
      t.float :gas_cost
      t.float :sprinkler_stub_cost
      t.float :sprinkler_grid_cost
      t.float :fire_alarm_cost
      t.float :line_set_pathways_cost
      t.string :structure
      t.text :structure_description
      t.boolean :structure_typical
      t.boolean :structure_complete
      t.string :structure_date
      t.float :structure_cost
      t.string :demolition
      t.text :demolition_description
      t.boolean :demolition_typical
      t.boolean :demolition_complete
      t.string :demolition_date
      t.float :demolition_cost
      t.string :other
      t.text :other_description
      t.boolean :other_typical
      t.boolean :other_complete
      t.string :other_date
      t.float :other_cost
      t.integer :structure_sqft
      t.float :structure_unit
      t.integer :slab_sqft
      t.float :slab_unit
      t.integer :studs_sqft
      t.float :studs_unit
      t.integer :drywall_sqft
      t.float :drywall_unit
      t.integer :insulation_sqft
      t.float :insulation_unit
      t.integer :service_door_sqft
      t.float :service_door_unit
      t.integer :storefront_sqft
      t.float :storefront_unit
      t.integer :hvac_unit_sqft
      t.float :hvac_unit_unit
      t.integer :supply_duct_sqft
      t.float :supply_duct_unit
      t.integer :exhaust_sqft
      t.float :exhaust_unit
      t.integer :line_set_pathways_sqft
      t.float :line_set_pathways_unit
      t.integer :ems_sqft
      t.float :ems_unit
      t.integer :electrical_sqft
      t.float :electrical_unit
      t.integer :voltage_sqft
      t.float :voltage_unit
      t.integer :amperage_sqft
      t.float :amperage_unit
      t.integer :conduit_size_sqft
      t.float :conduit_size_unit
      t.integer :electrical_meter_sqft
      t.float :electrical_meter_unit
      t.integer :telephone_sqft
      t.float :telephone_unit
      t.integer :sanitary_sqft
      t.float :sanitary_unit
      t.integer :sanitary_vent_sqft
      t.float :sanitary_vent_unit
      t.integer :grease_sqft
      t.float :grease_unit
      t.integer :water_sqft
      t.float :water_unit
      t.integer :gas_sqft
      t.float :gas_unit
      t.integer :sprinkler_stub_sqft
      t.float :sprinkler_stub_unit
      t.integer :sprinkler_grid_sqft
      t.float :sprinkler_grid_unit
      t.integer :fire_alarm_sqft
      t.float :fire_alarm_unit
      t.integer :demolition_sqft
      t.float :demolition_unit
      t.integer :other_sqft
      t.float :other_unit
      t.belongs_to :area, index: true, foreign_key: true

      t.timestamps
    end
  end
end
