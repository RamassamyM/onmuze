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

ActiveRecord::Schema.define(version: 20170531210938) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attachinary_files", force: :cascade do |t|
    t.string   "attachinariable_type"
    t.integer  "attachinariable_id"
    t.string   "scope"
    t.string   "public_id"
    t.string   "version"
    t.integer  "width"
    t.integer  "height"
    t.string   "format"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["attachinariable_type", "attachinariable_id", "scope"], name: "by_scoped_parent", using: :btree
  end

  create_table "events", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "scheduled_at"
    t.integer  "place_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["place_id"], name: "index_events_on_place_id", using: :btree
  end

  create_table "genres", force: :cascade do |t|
    t.string   "event_type"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "performances", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.text     "description"
    t.string   "address"
    t.string   "youtube_url"
    t.string   "facebook_url"
    t.string   "instagram_url"
    t.string   "soundcloud_url"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "genre_id"
    t.index ["genre_id"], name: "index_performances_on_genre_id", using: :btree
    t.index ["user_id"], name: "index_performances_on_user_id", using: :btree
  end

  create_table "places", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.float    "latitude"
    t.float    "longitude"
    t.index ["user_id"], name: "index_places_on_user_id", using: :btree
  end

  create_table "promotions", force: :cascade do |t|
    t.string   "name"
    t.text     "message"
    t.text     "eventpage_url"
    t.text     "picture_url"
    t.integer  "event_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["event_id"], name: "index_promotions_on_event_id", using: :btree
  end

  create_table "proposals", force: :cascade do |t|
    t.integer  "performance_id"
    t.integer  "event_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "status",         default: 0
    t.index ["event_id"], name: "index_proposals_on_event_id", using: :btree
    t.index ["performance_id"], name: "index_proposals_on_performance_id", using: :btree
  end

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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "events", "places"
  add_foreign_key "performances", "genres"
  add_foreign_key "performances", "users"
  add_foreign_key "places", "users"
  add_foreign_key "promotions", "events"
  add_foreign_key "proposals", "events"
  add_foreign_key "proposals", "performances"
end
