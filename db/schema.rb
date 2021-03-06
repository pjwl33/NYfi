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

ActiveRecord::Schema.define(version: 20140426201240) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: true do |t|
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "hotspot_id"
  end

  create_table "hotspots", force: true do |t|
    t.string  "name"
    t.string  "address"
    t.string  "biz_url"
    t.string  "wifi_type"
    t.string  "phone"
    t.string  "img_url"
    t.decimal "yelp_rating", precision: 8, scale: 2
  end

  create_table "hotspots_users", id: false, force: true do |t|
    t.integer "hotspot_id"
    t.integer "user_id"
  end

  create_table "somethings", force: true do |t|
  end

  create_table "users", force: true do |t|
    t.string  "name"
    t.string  "email"
    t.string  "password_digest"
    t.boolean "admin"
  end

end
