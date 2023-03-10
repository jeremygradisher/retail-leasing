class CreateWorkletterTemplates < ActiveRecord::Migration[5.0]
  def change
    create_table :workletter_templates do |t|
      t.string :template_name
      t.string :slab
      t.text :slab_description
      t.boolean :slab_typical
      t.string :studs
      t.text :studs_description
      t.boolean :studs_typical
      t.string :drywall
      t.text :drywall_description
      t.boolean :drywall_typical
      t.string :insulation
      t.text :insulation_description
      t.boolean :insulation_typical
      t.string :service_door
      t.text :service_door_description
      t.boolean :service_door_typical
      t.string :storefront
      t.text :storefront_description
      t.boolean :storefront_typical
      t.string :supply
      t.text :supply_description
      t.boolean :supply_typical
      t.string :exhaust
      t.text :exhaust_description
      t.boolean :exhaust_typical
      t.string :unit
      t.text :unit_description
      t.boolean :unit_typical
      t.string :line_set_pathways
      t.text :line_set_pathways_description
      t.boolean :line_set_pathways_typical
      t.string :ems
      t.text :ems_description
      t.boolean :ems_typical
      t.string :voltage
      t.text :voltage_description
      t.boolean :voltage_typical
      t.string :amperage
      t.text :amperage_description
      t.boolean :amperage_typical
      t.string :conduit_size
      t.text :conduit_size_description
      t.boolean :conduit_size_typical
      t.string :electrical
      t.text :electrical_description
      t.boolean :electrical_typical
      t.string :electrical_meter
      t.text :electrical_meter_description
      t.boolean :electrical_meter_typical
      t.string :telephone
      t.text :telephone_description
      t.boolean :telephone_typical
      t.string :sanitary
      t.text :sanitary_description
      t.boolean :sanitary_typical
      t.string :sanitary_vent
      t.text :sanitary_vent_description
      t.boolean :sanitary_vent_typical
      t.string :grease
      t.text :grease_description
      t.boolean :grease_typical
      t.string :water
      t.text :water_description
      t.boolean :water_typical
      t.string :gas
      t.text :gas_description
      t.boolean :gas_typical
      t.string :sprinkler_stub
      t.text :sprinkler_stub_description
      t.boolean :sprinkler_stub_typical
      t.string :sprinkler_grid
      t.text :sprinkler_grid_description
      t.boolean :sprinkler_grid_typical
      t.string :fire_alarm
      t.text :fire_alarm_description
      t.boolean :fire_alarm_typical
      t.string :structure
      t.text :structure_description
      t.boolean :structure_typical
      t.string :demolition
      t.text :demolition_description
      t.boolean :demolition_typical
      t.string :other
      t.text :other_description
      t.boolean :other_typical
      t.belongs_to :project, index: true, foreign_key: true

      t.timestamps
    end
  end
end
