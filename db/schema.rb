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

ActiveRecord::Schema.define(version: 20150213020244) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "neighborhoods", force: :cascade do |t|
    t.string   "label"
    t.string   "name"
    t.string   "state"
    t.float    "longitude"
    t.float    "latitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "neighborhoods", ["latitude", "longitude"], name: "index_neighborhoods_on_latitude_and_longitude", using: :btree

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

  add_foreign_key "profiles", "users"
  add_foreign_key "spots", "neighborhoods"
end
