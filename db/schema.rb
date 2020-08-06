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

ActiveRecord::Schema.define(version: 20200806202914) do

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
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
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
