# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_10_12_195521) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "areas", id: :serial, force: :cascade do |t|
    t.string "suite_number"
    t.string "status"
    t.string "coords"
    t.integer "map_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "project_id"
    t.integer "area_sqft"
    t.string "address"
    t.text "landlord_plan_notes"
    t.string "tenant_approval"
    t.text "area_comments"
    t.string "system_type"
    t.integer "quantity"
    t.string "unit_brand"
    t.string "unit_voltage"
    t.string "pipe_system"
    t.string "voltage"
    t.string "main_amperage"
    t.string "transformer"
    t.string "sub_panel_amperage"
    t.string "conduit_size"
    t.string "electric_meter_number"
    t.string "electric_meter_install_date"
    t.string "electric_meter_transfer_date"
    t.integer "restrooms"
    t.string "sanitary_size"
    t.string "sanitary_type"
    t.string "vent_size"
    t.string "water_size"
    t.string "water_meter_number"
    t.string "sub_meter_number"
    t.string "sub_meter_install_date"
    t.string "sub_meter_transfer_date"
    t.string "gas_size"
    t.string "gas_meter"
    t.string "gas_meter_install_date"
    t.string "gas_meter_transfer_date"
    t.string "grease_size"
    t.integer "tonnage"
    t.integer "vav_size"
    t.integer "conduit_quantity"
    t.string "telephone_conduit_size"
    t.string "telephone_conduit_quantity"
    t.string "pipe_system_note"
    t.float "area_budget_rate"
    t.string "service_door_quantity"
    t.index ["map_id"], name: "index_areas_on_map_id"
    t.index ["project_id"], name: "index_areas_on_project_id"
  end

  create_table "areas_deals", id: :serial, force: :cascade do |t|
    t.integer "area_id"
    t.integer "deal_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "project_id"
    t.index ["area_id", "deal_id"], name: "by_area_and_deal", unique: true
    t.index ["area_id"], name: "index_areas_deals_on_area_id"
    t.index ["deal_id"], name: "index_areas_deals_on_deal_id"
    t.index ["project_id"], name: "index_areas_deals_on_project_id"
  end

  create_table "contacts", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "phone"
    t.string "address"
    t.integer "project_id"
    t.text "notes"
    t.text "additional"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "deal_id"
    t.index ["deal_id"], name: "index_contacts_on_deal_id"
    t.index ["project_id"], name: "index_contacts_on_project_id"
  end

  create_table "dealimages", id: :serial, force: :cascade do |t|
    t.string "dealimage"
    t.integer "deal_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["deal_id"], name: "index_dealimages_on_deal_id"
  end

  create_table "deals", id: :serial, force: :cascade do |t|
    t.string "deal_name"
    t.integer "gross_area"
    t.integer "net_rentable_area"
    t.string "lease_status"
    t.integer "map_id"
    t.integer "project_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "merchandising_status"
    t.string "turn_over_condition"
    t.string "lease_execution"
    t.string "welcome_package"
    t.string "base_building_cds"
    t.string "kick_off_call"
    t.string "landlord_work_sent"
    t.string "signage_received"
    t.string "signage_sent"
    t.text "signage_notes"
    t.string "permit_submitted"
    t.string "permit_received"
    t.text "permit_notes"
    t.string "check_in"
    t.string "premises_acceptance"
    t.string "construction_start"
    t.string "lay_out_rough_in"
    t.string "fit_out_finishes"
    t.string "fixtures"
    t.string "final_inspections"
    t.string "merchandising"
    t.string "open_for_business"
    t.string "punchlist_request"
    t.string "punchlist_inspection"
    t.string "punchlist_complete"
    t.string "certificate_of_occupancy"
    t.string "as_builts_received"
    t.string "final_plans_received"
    t.string "final_plans_reviewed"
    t.text "final_plans_notes"
    t.string "cad_release_form"
    t.string "close_out_letter"
    t.string "final_lien_waver"
    t.string "construction_cost_summary"
    t.string "sprinkler_shop_drawings"
    t.string "sprinkler_work_order"
    t.string "sprinkler_check"
    t.string "air_balance_report"
    t.string "deposit_release_approved"
    t.string "deposit_released"
    t.string "ta_ti_release_approved"
    t.string "ta_ti_released"
    t.float "final_construction_cost"
    t.string "certificate_of_insurance"
    t.string "w9"
    t.float "utility_cost"
    t.float "tenant_cost"
    t.text "close_out_notes"
    t.string "final_plans_status"
    t.string "signage_status"
    t.string "signage_reviewed"
    t.string "storefront_plans_received"
    t.string "storefront_plans_reviewed"
    t.string "storefront_plans_status"
    t.text "storefront_notes"
    t.string "expiration"
    t.string "date_of_possession"
    t.string "fit_out_duration"
    t.text "abatement"
    t.float "taxes"
    t.float "base_rent"
    t.float "total_base_rent"
    t.float "percentage_of_rent"
    t.float "ti_allowance"
    t.float "ti_cost"
    t.float "ll_work"
    t.float "ll_work_cost"
    t.float "cam"
    t.float "cam_cost"
    t.float "comm_inside"
    t.float "comm_outside"
    t.float "taxes_cost"
    t.float "insurance"
    t.float "insurance_cost"
    t.float "marketing"
    t.float "marketing_cost"
    t.float "trash"
    t.float "trash_cost"
    t.float "other"
    t.float "other_cost"
    t.float "break_point"
    t.float "fee_sqft_total"
    t.float "fee_cost_total"
    t.float "go_marketing"
    t.float "go_marketing_cost"
    t.float "fit_out"
    t.float "fit_out_cost"
    t.text "status_notes"
    t.string "leasing_manager"
    t.float "budget_rate"
    t.string "fit_out_duration_if"
    t.float "budget_ti"
    t.float "base_building_cost"
    t.float "cash_on_cash"
    t.float "budget_variance"
    t.float "increase"
    t.string "action_required"
    t.boolean "owner_approval"
    t.boolean "priority"
    t.text "term_notes"
    t.string "tenant_documents"
    t.string "landlord_work"
    t.boolean "archive"
    t.text "tenant_description"
    t.text "key_contacts"
    t.text "architect"
    t.text "general_contractor"
    t.text "other_contacts"
    t.text "tenant_contact"
    t.integer "deal_term"
    t.string "signage_install_date"
    t.index ["map_id"], name: "index_deals_on_map_id"
    t.index ["project_id"], name: "index_deals_on_project_id"
  end

  create_table "delayed_jobs", id: :serial, force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at", precision: nil
    t.datetime "locked_at", precision: nil
    t.datetime "failed_at", precision: nil
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "icons", id: :serial, force: :cascade do |t|
    t.integer "project_id"
    t.string "icon"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "images", id: :serial, force: :cascade do |t|
    t.integer "map_id"
    t.string "image"
    t.string "width"
    t.string "height"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "project_id"
    t.index ["project_id"], name: "index_images_on_project_id"
  end

  create_table "leasing_managers", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "phone"
    t.integer "project_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["project_id"], name: "index_leasing_managers_on_project_id"
  end

  create_table "maps", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "key"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "project_id"
    t.index ["project_id"], name: "index_maps_on_project_id"
  end

  create_table "notifications", id: :serial, force: :cascade do |t|
    t.integer "recipient_id"
    t.integer "actor_id"
    t.datetime "read_at", precision: nil
    t.string "action"
    t.integer "notifiable_id"
    t.string "notifiable_type"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "primary_deals", id: :serial, force: :cascade do |t|
    t.integer "area_id"
    t.integer "deal_id"
    t.integer "project_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["area_id"], name: "index_primary_deals_on_area_id"
    t.index ["deal_id"], name: "index_primary_deals_on_deal_id"
    t.index ["project_id"], name: "index_primary_deals_on_project_id"
  end

  create_table "projects", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "user_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "address"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.string "project_type"
    t.text "description"
    t.string "owner"
    t.string "owner_address"
    t.string "owner_city"
    t.string "owner_state"
    t.string "owner_zip"
    t.string "owner_contact"
    t.string "owner_email"
    t.string "owner_phone"
    t.integer "project_square_feet"
    t.string "status"
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "schedules", id: :serial, force: :cascade do |t|
    t.integer "map_id"
    t.string "lease_execution_date"
    t.string "final_plans_received_date"
    t.string "final_plans_reviewed_date"
    t.string "permit_submitted_date"
    t.string "permit_received_date"
    t.string "premises_acceptance_date"
    t.string "construction_completion_date"
    t.string "open_for_business_date"
    t.integer "total_days"
    t.integer "design_duration"
    t.integer "ll_review_duration"
    t.integer "permit_submittal_duration"
    t.integer "permit_reviewed_duration"
    t.integer "mobilization_duration"
    t.integer "tenant_fit_out_duration"
    t.integer "merchandising_duration"
    t.integer "area_id"
    t.integer "project_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "deal_id"
    t.index ["area_id"], name: "index_schedules_on_area_id"
    t.index ["project_id"], name: "index_schedules_on_project_id"
  end

  create_table "user_avatars", id: :serial, force: :cascade do |t|
    t.string "avatar"
    t.integer "user_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["user_id"], name: "index_user_avatars_on_user_id"
  end

  create_table "user_projects", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "project_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["project_id"], name: "index_user_projects_on_project_id"
    t.index ["user_id", "project_id"], name: "by_user_and_project", unique: true
    t.index ["user_id"], name: "index_user_projects_on_user_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.boolean "is_admin", default: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at", precision: nil
    t.datetime "last_sign_in_at", precision: nil
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at", precision: nil
    t.datetime "confirmation_sent_at", precision: nil
    t.string "unconfirmed_email"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "first_name"
    t.string "last_name"
    t.string "role"
    t.integer "invited_by"
    t.integer "project_id"
    t.string "invitation_token"
    t.datetime "invitation_created_at", precision: nil
    t.datetime "invitation_sent_at", precision: nil
    t.datetime "invitation_accepted_at", precision: nil
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.integer "invited_by_id"
    t.integer "invitations_count", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invitations_count"], name: "index_users_on_invitations_count"
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by_type_and_invited_by_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role"], name: "index_users_on_role"
  end

  create_table "workletter_templates", id: :serial, force: :cascade do |t|
    t.string "template_name"
    t.string "slab"
    t.text "slab_description"
    t.boolean "slab_typical"
    t.string "studs"
    t.text "studs_description"
    t.boolean "studs_typical"
    t.string "drywall"
    t.text "drywall_description"
    t.boolean "drywall_typical"
    t.string "insulation"
    t.text "insulation_description"
    t.boolean "insulation_typical"
    t.string "service_door"
    t.text "service_door_description"
    t.boolean "service_door_typical"
    t.string "storefront"
    t.text "storefront_description"
    t.boolean "storefront_typical"
    t.string "supply"
    t.text "supply_description"
    t.boolean "supply_typical"
    t.string "exhaust"
    t.text "exhaust_description"
    t.boolean "exhaust_typical"
    t.string "unit"
    t.text "unit_description"
    t.boolean "unit_typical"
    t.string "line_set_pathways"
    t.text "line_set_pathways_description"
    t.boolean "line_set_pathways_typical"
    t.string "ems"
    t.text "ems_description"
    t.boolean "ems_typical"
    t.string "voltage"
    t.text "voltage_description"
    t.boolean "voltage_typical"
    t.string "amperage"
    t.text "amperage_description"
    t.boolean "amperage_typical"
    t.string "conduit_size"
    t.text "conduit_size_description"
    t.boolean "conduit_size_typical"
    t.string "electrical"
    t.text "electrical_description"
    t.boolean "electrical_typical"
    t.string "electrical_meter"
    t.text "electrical_meter_description"
    t.boolean "electrical_meter_typical"
    t.string "telephone"
    t.text "telephone_description"
    t.boolean "telephone_typical"
    t.string "sanitary"
    t.text "sanitary_description"
    t.boolean "sanitary_typical"
    t.string "sanitary_vent"
    t.text "sanitary_vent_description"
    t.boolean "sanitary_vent_typical"
    t.string "grease"
    t.text "grease_description"
    t.boolean "grease_typical"
    t.string "water"
    t.text "water_description"
    t.boolean "water_typical"
    t.string "gas"
    t.text "gas_description"
    t.boolean "gas_typical"
    t.string "sprinkler_stub"
    t.text "sprinkler_stub_description"
    t.boolean "sprinkler_stub_typical"
    t.string "sprinkler_grid"
    t.text "sprinkler_grid_description"
    t.boolean "sprinkler_grid_typical"
    t.string "fire_alarm"
    t.text "fire_alarm_description"
    t.boolean "fire_alarm_typical"
    t.string "structure"
    t.text "structure_description"
    t.boolean "structure_typical"
    t.string "demolition"
    t.text "demolition_description"
    t.boolean "demolition_typical"
    t.string "other"
    t.text "other_description"
    t.boolean "other_typical"
    t.integer "project_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["project_id"], name: "index_workletter_templates_on_project_id"
  end

  create_table "workletters", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "project_id"
    t.integer "map_id"
    t.integer "ll_count_total"
    t.string "slab"
    t.string "studs"
    t.string "drywall"
    t.string "insulation"
    t.string "service_door"
    t.string "storefront"
    t.string "supply"
    t.string "exhaust"
    t.string "unit"
    t.string "line_set_pathways"
    t.string "ems"
    t.string "voltage"
    t.string "amperage"
    t.string "conduit_size"
    t.string "electrical_meter"
    t.string "tele_conduit_size"
    t.string "sanitary"
    t.string "sanitary_vent"
    t.string "grease"
    t.string "water"
    t.string "gas"
    t.string "sprinkler_stub"
    t.string "sprinkler_grid"
    t.string "fire_alarm"
    t.text "slab_description"
    t.text "studs_description"
    t.text "drywall_description"
    t.text "storefront_description"
    t.text "servicedoor_description"
    t.text "untis_description"
    t.text "supplyduct_description"
    t.text "exhaustduct_description"
    t.text "linesetpathway_description"
    t.text "emergency_description"
    t.text "voltage_description"
    t.text "amperage_description"
    t.text "conduitsize_description"
    t.text "panels_description"
    t.text "meter_description"
    t.text "telephone_description"
    t.text "sanitary_description"
    t.text "sanitaryvent_description"
    t.text "grease_description"
    t.text "water_description"
    t.text "gas_description"
    t.text "sprinklerstub_description"
    t.text "sprinklergrid_description"
    t.text "firealarm_description"
    t.text "insulation_description"
    t.boolean "slab_complete"
    t.boolean "slab_typical"
    t.string "slab_date"
    t.boolean "studs_typical"
    t.boolean "drywall_typical"
    t.boolean "insulation_typical"
    t.boolean "service_door_typical"
    t.boolean "storefront_typical"
    t.boolean "supply_duct_typical"
    t.boolean "exhaust_duct_typical"
    t.boolean "unit_typical"
    t.boolean "line_set_pathways_typical"
    t.boolean "ems_typical"
    t.boolean "voltage_typical"
    t.boolean "amperage_typical"
    t.boolean "conduit_size_typical"
    t.boolean "electrical_meter_typical"
    t.boolean "telephone_typical"
    t.boolean "sanitary_typical"
    t.boolean "sanitary_vent_typical"
    t.boolean "grease_typical"
    t.boolean "water_typical"
    t.boolean "gas_typical"
    t.boolean "sprinkler_stub_typical"
    t.boolean "sprinkler_grid_typical"
    t.boolean "fire_alarm_typical"
    t.boolean "studs_complete"
    t.boolean "drywall_complete"
    t.boolean "insulation_complete"
    t.boolean "service_door_complete"
    t.boolean "storefront_complete"
    t.boolean "supply_duct_complete"
    t.boolean "exhaust_duct_complete"
    t.boolean "unit_complete"
    t.boolean "line_set_pathways_complete"
    t.boolean "ems_complete"
    t.boolean "voltage_complete"
    t.boolean "amperage_complete"
    t.boolean "conduit_size_complete"
    t.boolean "electrical_meter_complete"
    t.boolean "telephone_complete"
    t.boolean "sanitary_complete"
    t.boolean "sanitary_vent_complete"
    t.boolean "grease_complete"
    t.boolean "water_complete"
    t.boolean "gas_complete"
    t.boolean "sprinkler_stub_complete"
    t.boolean "sprinkler_grid_complete"
    t.boolean "fire_alarm_complete"
    t.string "studs_date"
    t.string "drywall_date"
    t.string "insulation_date"
    t.string "service_door_date"
    t.string "storefront_date"
    t.string "supply_date"
    t.string "exhaust_date"
    t.string "unit_date"
    t.string "line_set_pathways_date"
    t.string "ems_date"
    t.string "voltage_date"
    t.string "amperage_date"
    t.string "conduit_size_date"
    t.string "electrical_meter_date"
    t.string "tele_conduit_size_date"
    t.string "sanitary_date"
    t.string "grease_date"
    t.string "water_date"
    t.string "sprinkler_stub_date"
    t.string "sprinkler_grid_date"
    t.string "fire_alarm_date"
    t.string "gas_date"
    t.string "sanitary_vent_date"
    t.string "electrical"
    t.text "electrical_description"
    t.boolean "electrical_typical"
    t.string "electrical_responsibility"
    t.boolean "electrical_complete"
    t.string "electrical_date"
    t.float "ll_work"
    t.float "ll_work_cost"
    t.float "slab_cost"
    t.float "studs_cost"
    t.float "drywall_cost"
    t.float "insulation_cost"
    t.float "service_door_cost"
    t.float "storefront_cost"
    t.float "supply_cost"
    t.float "exhaust_cost"
    t.float "unit_cost"
    t.float "ems_cost"
    t.float "voltage_cost"
    t.float "amperage_cost"
    t.float "conduit_size_cost"
    t.float "electrical_cost"
    t.float "electrical_meter_cost"
    t.float "telephone_cost"
    t.float "sanitary_cost"
    t.float "sanitary_vent_cost"
    t.float "grease_cost"
    t.float "water_cost"
    t.float "gas_cost"
    t.float "sprinkler_stub_cost"
    t.float "sprinkler_grid_cost"
    t.float "fire_alarm_cost"
    t.float "line_set_pathways_cost"
    t.string "structure"
    t.text "structure_description"
    t.boolean "structure_typical"
    t.boolean "structure_complete"
    t.string "structure_date"
    t.float "structure_cost"
    t.string "demolition"
    t.text "demolition_description"
    t.boolean "demolition_typical"
    t.boolean "demolition_complete"
    t.string "demolition_date"
    t.float "demolition_cost"
    t.string "other"
    t.text "other_description"
    t.boolean "other_typical"
    t.boolean "other_complete"
    t.string "other_date"
    t.float "other_cost"
    t.integer "structure_sqft"
    t.float "structure_unit"
    t.integer "slab_sqft"
    t.float "slab_unit"
    t.integer "studs_sqft"
    t.float "studs_unit"
    t.integer "drywall_sqft"
    t.float "drywall_unit"
    t.integer "insulation_sqft"
    t.float "insulation_unit"
    t.integer "service_door_sqft"
    t.float "service_door_unit"
    t.integer "storefront_sqft"
    t.float "storefront_unit"
    t.integer "hvac_unit_sqft"
    t.float "hvac_unit_unit"
    t.integer "supply_duct_sqft"
    t.float "supply_duct_unit"
    t.integer "exhaust_sqft"
    t.float "exhaust_unit"
    t.integer "line_set_pathways_sqft"
    t.float "line_set_pathways_unit"
    t.integer "ems_sqft"
    t.float "ems_unit"
    t.integer "electrical_sqft"
    t.float "electrical_unit"
    t.integer "voltage_sqft"
    t.float "voltage_unit"
    t.integer "amperage_sqft"
    t.float "amperage_unit"
    t.integer "conduit_size_sqft"
    t.float "conduit_size_unit"
    t.integer "electrical_meter_sqft"
    t.float "electrical_meter_unit"
    t.integer "telephone_sqft"
    t.float "telephone_unit"
    t.integer "sanitary_sqft"
    t.float "sanitary_unit"
    t.integer "sanitary_vent_sqft"
    t.float "sanitary_vent_unit"
    t.integer "grease_sqft"
    t.float "grease_unit"
    t.integer "water_sqft"
    t.float "water_unit"
    t.integer "gas_sqft"
    t.float "gas_unit"
    t.integer "sprinkler_stub_sqft"
    t.float "sprinkler_stub_unit"
    t.integer "sprinkler_grid_sqft"
    t.float "sprinkler_grid_unit"
    t.integer "fire_alarm_sqft"
    t.float "fire_alarm_unit"
    t.integer "demolition_sqft"
    t.float "demolition_unit"
    t.integer "other_sqft"
    t.float "other_unit"
    t.integer "area_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "deal_id"
    t.index ["area_id"], name: "index_workletters_on_area_id"
  end

  add_foreign_key "areas", "maps"
  add_foreign_key "areas_deals", "areas"
  add_foreign_key "areas_deals", "deals"
  add_foreign_key "dealimages", "deals"
  add_foreign_key "deals", "maps"
  add_foreign_key "deals", "projects"
  add_foreign_key "leasing_managers", "projects"
  add_foreign_key "primary_deals", "areas"
  add_foreign_key "primary_deals", "deals"
  add_foreign_key "primary_deals", "projects"
  add_foreign_key "projects", "users"
  add_foreign_key "schedules", "areas"
  add_foreign_key "schedules", "projects"
  add_foreign_key "user_avatars", "users"
  add_foreign_key "user_projects", "projects"
  add_foreign_key "user_projects", "users"
  add_foreign_key "workletter_templates", "projects"
  add_foreign_key "workletters", "areas"
end
