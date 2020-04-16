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

ActiveRecord::Schema.define(version: 20200416150159) do

  create_table "areas", force: :cascade do |t|
    t.string   "suite_number"
    t.integer  "map_id"
    t.string   "status"
    t.string   "coords"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "project_id"
    t.integer  "area_sqft"
    t.index ["map_id"], name: "index_areas_on_map_id"
    t.index ["project_id"], name: "index_areas_on_project_id"
  end

  create_table "areas_deals", force: :cascade do |t|
    t.integer  "area_id"
    t.integer  "deal_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["area_id", "deal_id"], name: "by_area_and_deal", unique: true
    t.index ["area_id"], name: "index_areas_deals_on_area_id"
    t.index ["deal_id"], name: "index_areas_deals_on_deal_id"
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
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
