# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20200825204602) do

  create_table "areas", force: :cascade do |t|
    t.string   "suite_number"
    t.integer  "map_id"
    t.string   "status"
    t.string   "coords"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "project_id"
    t.integer  "area_sqft"
    t.string   "address"
    t.text     "landlord_plan_notes"
    t.string   "tenant_approval"
    t.text     "area_comments"
    t.string   "system_type"
    t.integer  "quantity"
    t.string   "unit_brand"
    t.string   "unit_voltage"
    t.string   "pipe_system"
    t.string   "voltage"
    t.string   "main_amperage"
    t.string   "transformer"
    t.string   "sub_panel_amperage"
    t.string   "conduit_size"
    t.string   "electric_meter_number"
    t.string   "electric_meter_install_date"
    t.string   "electric_meter_transfer_date"
    t.integer  "restrooms"
    t.string   "sanitary_size"
    t.string   "sanitary_type"
    t.string   "vent_size"
    t.string   "water_size"
    t.string   "water_meter_number"
    t.string   "sub_meter_number"
    t.string   "sub_meter_install_date"
    t.string   "sub_meter_transfer_date"
    t.string   "gas_size"
    t.string   "gas_meter"
    t.string   "gas_meter_install_date"
    t.string   "gas_meter_transfer_date"
    t.string   "grease_size"
    t.integer  "tonnage"
    t.integer  "vav_size"
    t.integer  "conduit_quantity"
    t.string   "telephone_conduit_size"
    t.string   "telephone_conduit_quantity"
    t.string   "pipe_system_note"
    t.float    "area_budget_rate"
    t.string   "service_door_quantity"
    t.index ["map_id"], name: "index_areas_on_map_id"
    t.index ["project_id"], name: "index_areas_on_project_id"
  end

  create_table "areas_deals", force: :cascade do |t|
    t.integer  "area_id"
    t.integer  "deal_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "project_id"
    t.index ["area_id", "deal_id"], name: "by_area_and_deal", unique: true
    t.index ["area_id"], name: "index_areas_deals_on_area_id"
    t.index ["deal_id"], name: "index_areas_deals_on_deal_id"
    t.index ["project_id"], name: "index_areas_deals_on_project_id"
  end

  create_table "dealimages", force: :cascade do |t|
    t.integer  "deal_id"
    t.string   "dealimage"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deal_id"], name: "index_dealimages_on_deal_id"
  end

  create_table "deals", force: :cascade do |t|
    t.string   "deal_name"
    t.integer  "gross_area"
    t.integer  "net_rentable_area"
    t.string   "lease_status"
    t.integer  "project_id"
    t.integer  "map_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "merchandising_status"
    t.string   "turn_over_condition"
    t.string   "lease_execution"
    t.string   "welcome_package"
    t.string   "base_building_cds"
    t.string   "kick_off_call"
    t.string   "landlord_work_sent"
    t.string   "signage_received"
    t.string   "signage_sent"
    t.text     "signage_notes"
    t.string   "permit_submitted"
    t.string   "permit_received"
    t.text     "permit_notes"
    t.string   "check_in"
    t.string   "premises_acceptance"
    t.string   "construction_start"
    t.string   "lay_out_rough_in"
    t.string   "fit_out_finishes"
    t.string   "fixtures"
    t.string   "final_inspections"
    t.string   "merchandising"
    t.string   "open_for_business"
    t.string   "punchlist_request"
    t.string   "punchlist_inspection"
    t.string   "punchlist_complete"
    t.string   "certificate_of_occupancy"
    t.string   "as_builts_received"
    t.string   "final_plans_received"
    t.string   "final_plans_reviewed"
    t.text     "final_plans_notes"
    t.string   "cad_release_form"
    t.string   "close_out_letter"
    t.string   "final_lien_waver"
    t.string   "construction_cost_summary"
    t.string   "sprinkler_shop_drawings"
    t.string   "sprinkler_work_order"
    t.string   "sprinkler_check"
    t.string   "air_balance_report"
    t.string   "deposit_release_approved"
    t.string   "deposit_released"
    t.string   "ta_ti_release_approved"
    t.string   "ta_ti_released"
    t.float    "final_construction_cost"
    t.string   "certificate_of_insurance"
    t.string   "w9"
    t.float    "utility_cost"
    t.float    "tenant_cost"
    t.text     "close_out_notes"
    t.string   "final_plans_status"
    t.string   "signage_status"
    t.string   "signage_reviewed"
    t.string   "storefront_plans_received"
    t.string   "storefront_plans_reviewed"
    t.string   "storefront_plans_status"
    t.text     "storefront_notes"
    t.string   "expiration"
    t.string   "date_of_possession"
    t.string   "fit_out_duration"
    t.text     "abatement"
    t.float    "taxes"
    t.float    "base_rent"
    t.float    "total_base_rent"
    t.float    "percentage_of_rent"
    t.float    "ti_allowance"
    t.float    "ti_cost"
    t.float    "ll_work"
    t.float    "ll_work_cost"
    t.float    "cam"
    t.float    "cam_cost"
    t.float    "comm_inside"
    t.float    "comm_outside"
    t.float    "taxes_cost"
    t.float    "insurance"
    t.float    "insurance_cost"
    t.float    "marketing"
    t.float    "marketing_cost"
    t.float    "trash"
    t.float    "trash_cost"
    t.float    "other"
    t.float    "other_cost"
    t.float    "break_point"
    t.float    "fee_sqft_total"
    t.float    "fee_cost_total"
    t.float    "go_marketing"
    t.float    "go_marketing_cost"
    t.float    "fit_out"
    t.float    "fit_out_cost"
    t.text     "status_notes"
    t.string   "leasing_manager"
    t.float    "budget_rate"
    t.string   "fit_out_duration_if"
    t.float    "budget_ti"
    t.float    "base_building_cost"
    t.float    "cash_on_cash"
    t.float    "budget_variance"
    t.float    "increase"
    t.string   "action_required"
    t.boolean  "owner_approval"
    t.boolean  "priority"
    t.text     "term_notes"
    t.string   "tenant_documents"
    t.string   "landlord_work"
    t.boolean  "archive"
    t.text     "tenant_description"
    t.text     "key_contacts"
    t.text     "architect"
    t.text     "general_contractor"
    t.text     "other_contacts"
    t.text     "tenant_contact"
    t.integer  "deal_term"
    t.index ["map_id"], name: "index_deals_on_map_id"
    t.index ["project_id"], name: "index_deals_on_project_id"
  end

  create_table "icons", force: :cascade do |t|
    t.integer  "project_id"
    t.string   "icon"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "images", force: :cascade do |t|
    t.integer  "map_id"
    t.string   "image"
    t.string   "width"
    t.string   "height"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "project_id"
    t.index ["project_id"], name: "index_images_on_project_id"
  end

  create_table "maps", force: :cascade do |t|
    t.string   "name"
    t.string   "key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "project_id"
    t.index ["project_id"], name: "index_maps_on_project_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "schedules", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "map_id"
    t.integer  "area_id"
    t.string   "lease_execution_date"
    t.string   "final_plans_received_date"
    t.string   "final_plans_reviewed_date"
    t.string   "permit_submitted_date"
    t.string   "permit_received_date"
    t.string   "premises_acceptance_date"
    t.string   "construction_completion_date"
    t.string   "open_for_business_date"
    t.integer  "total_days"
    t.integer  "design_duration"
    t.integer  "ll_review_duration"
    t.integer  "permit_submittal_duration"
    t.integer  "permit_reviewed_duration"
    t.integer  "mobilization_duration"
    t.integer  "tenant_fit_out_duration"
    t.integer  "merchandising_duration"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["area_id"], name: "index_schedules_on_area_id"
    t.index ["project_id"], name: "index_schedules_on_project_id"
  end

  create_table "user_avatars", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "avatar"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_avatars_on_user_id"
  end

  create_table "user_projects", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_user_projects_on_project_id"
    t.index ["user_id", "project_id"], name: "by_user_and_project", unique: true
    t.index ["user_id"], name: "index_user_projects_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.boolean  "is_admin",               default: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "role"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role"], name: "index_users_on_role"
  end

end
