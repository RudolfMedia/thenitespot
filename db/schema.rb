# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150410050730) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.integer  "sort"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "parent_id"
  end

  add_index "categories", ["sort"], name: "index_categories_on_sort", using: :btree

  create_table "categorizations", force: :cascade do |t|
    t.integer  "categorizable_id"
    t.string   "categorizable_type"
    t.integer  "category_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "categorizations", ["categorizable_id"], name: "index_categorizations_on_categorizable_id", using: :btree
  add_index "categorizations", ["categorizable_type"], name: "index_categorizations_on_categorizable_type", using: :btree
  add_index "categorizations", ["category_id"], name: "index_categorizations_on_category_id", using: :btree

  create_table "checkins", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "spot_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "checkins", ["spot_id"], name: "index_checkins_on_spot_id", using: :btree
  add_index "checkins", ["user_id"], name: "index_checkins_on_user_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.string   "name",         default: "", null: false
    t.string   "slug"
    t.text     "about"
    t.string   "age"
    t.string   "entry"
    t.string   "entry_fee"
    t.integer  "spot_id"
    t.string   "phone"
    t.string   "email"
    t.string   "ticket_url"
    t.string   "website_url"
    t.string   "facebook_url"
    t.string   "twitter_url"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "events", ["slug"], name: "index_events_on_slug", using: :btree
  add_index "events", ["spot_id"], name: "index_events_on_spot_id", using: :btree

  create_table "favorites", force: :cascade do |t|
    t.integer  "spot_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "favorites", ["spot_id"], name: "index_favorites_on_spot_id", using: :btree
  add_index "favorites", ["user_id"], name: "index_favorites_on_user_id", using: :btree

  create_table "features", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hours", force: :cascade do |t|
    t.integer  "spot_id"
    t.string   "days",       default: [],              array: true
    t.time     "open",                    null: false
    t.time     "close",                   null: false
    t.string   "note"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "hours", ["spot_id"], name: "index_hours_on_spot_id", using: :btree

  create_table "images", force: :cascade do |t|
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.string   "file"
    t.boolean  "is_primary"
    t.boolean  "is_bg"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "images", ["imageable_type", "imageable_id"], name: "index_images_on_imageable_type_and_imageable_id", using: :btree

  create_table "menu_items", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.float    "price"
    t.integer  "menu_section_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "menu_items", ["menu_section_id"], name: "index_menu_items_on_menu_section_id", using: :btree

  create_table "menu_sections", force: :cascade do |t|
    t.integer  "menu_id"
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "menu_sections", ["menu_id"], name: "index_menu_sections_on_menu_id", using: :btree

  create_table "menus", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "sort"
    t.integer  "spot_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "menus", ["spot_id"], name: "index_menus_on_spot_id", using: :btree

  create_table "neighborhoods", force: :cascade do |t|
    t.string   "label"
    t.string   "name"
    t.string   "state"
    t.float    "longitude"
    t.float    "latitude"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "spots_count", default: 0
  end

  add_index "neighborhoods", ["latitude", "longitude"], name: "index_neighborhoods_on_latitude_and_longitude", using: :btree

  create_table "occurrences", force: :cascade do |t|
    t.integer  "event_id"
    t.date     "start_date",      null: false
    t.time     "start_time"
    t.date     "end_date"
    t.time     "end_time"
    t.date     "expiration_date", null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "occurrences", ["event_id"], name: "index_occurrences_on_event_id", using: :btree
  add_index "occurrences", ["expiration_date"], name: "index_occurrences_on_expiration_date", using: :btree

  create_table "profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "gender"
    t.date     "dob"
    t.string   "current_city"
    t.string   "current_state"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", using: :btree

  create_table "reports", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "reportable_id"
    t.string   "reportable_type"
    t.integer  "issue"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "reports", ["reportable_type", "reportable_id"], name: "index_reports_on_reportable_type_and_reportable_id", using: :btree
  add_index "reports", ["user_id"], name: "index_reports_on_user_id", using: :btree

  create_table "specials", force: :cascade do |t|
    t.integer  "spot_id"
    t.string   "name",                     null: false
    t.string   "description"
    t.string   "days",        default: [],              array: true
    t.time     "start_time"
    t.time     "end_time"
    t.integer  "sort",                     null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "specials", ["spot_id"], name: "index_specials_on_spot_id", using: :btree

  create_table "spot_features", force: :cascade do |t|
    t.integer  "spot_id"
    t.integer  "feature_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "spot_features", ["feature_id"], name: "index_spot_features_on_feature_id", using: :btree
  add_index "spot_features", ["spot_id"], name: "index_spot_features_on_spot_id", using: :btree

  create_table "spots", force: :cascade do |t|
    t.string   "name",            default: "", null: false
    t.string   "slug"
    t.boolean  "eat"
    t.boolean  "drink"
    t.boolean  "attend"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "neighborhood_id"
    t.string   "phone"
    t.string   "email"
    t.text     "about"
    t.string   "price"
    t.string   "payment_opts",    default: [],              array: true
    t.string   "website_url"
    t.string   "reservation_url"
    t.string   "menu_url"
    t.string   "facebook_url"
    t.string   "twitter_url"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "spots", ["attend"], name: "index_spots_on_attend", using: :btree
  add_index "spots", ["drink"], name: "index_spots_on_drink", using: :btree
  add_index "spots", ["eat"], name: "index_spots_on_eat", using: :btree
  add_index "spots", ["latitude"], name: "index_spots_on_latitude", using: :btree
  add_index "spots", ["longitude"], name: "index_spots_on_longitude", using: :btree
  add_index "spots", ["neighborhood_id"], name: "index_spots_on_neighborhood_id", using: :btree
  add_index "spots", ["price"], name: "index_spots_on_price", using: :btree
  add_index "spots", ["slug"], name: "index_spots_on_slug", unique: true, using: :btree

  create_table "user_roles", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.integer  "role"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "user_roles", ["resource_type", "resource_id"], name: "index_user_roles_on_resource_type_and_resource_id", using: :btree
  add_index "user_roles", ["role"], name: "index_user_roles_on_role", using: :btree
  add_index "user_roles", ["user_id"], name: "index_user_roles_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "auth_token"
  end

  add_index "users", ["auth_token"], name: "index_users_on_auth_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "checkins", "spots"
  add_foreign_key "checkins", "users"
  add_foreign_key "events", "spots"
  add_foreign_key "favorites", "spots"
  add_foreign_key "favorites", "users"
  add_foreign_key "hours", "spots"
  add_foreign_key "menu_items", "menu_sections"
  add_foreign_key "menu_sections", "menus"
  add_foreign_key "menus", "spots"
  add_foreign_key "occurrences", "events"
  add_foreign_key "profiles", "users"
  add_foreign_key "reports", "users"
  add_foreign_key "specials", "spots"
  add_foreign_key "spot_features", "features"
  add_foreign_key "spot_features", "spots"
  add_foreign_key "spots", "neighborhoods"
  add_foreign_key "user_roles", "users"
end
