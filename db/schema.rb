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

ActiveRecord::Schema.define(version: 20160223121335) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "replies", force: :cascade do |t|
    t.integer "user_id"
    t.integer "travel_id"
    t.text    "content"
  end

  create_table "reply_others", force: :cascade do |t|
    t.integer  "user_other_id"
    t.integer  "travel_other_id"
    t.text     "content"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "travel_others", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "point_of_departure"
    t.string   "destination"
    t.date     "date_of_departure"
    t.integer  "dates"
    t.integer  "budget"
    t.text     "intro"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "travels", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "point_of_departure"
    t.string   "destination"
    t.date     "date_of_departure"
    t.integer  "dates"
    t.integer  "budget"
    t.text     "intro"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_others", force: :cascade do |t|
    t.string  "name"
    t.integer "qq"
    t.string  "weibo"
    t.string  "img_url"
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
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

end