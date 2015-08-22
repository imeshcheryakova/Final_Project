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

ActiveRecord::Schema.define(version: 20150822215051) do

  create_table "exercises", force: :cascade do |t|
    t.string   "weather"
    t.integer  "calories_per_hour"
    t.string   "exercise"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "meals", force: :cascade do |t|
    t.integer  "calories_per_portion"
    t.string   "meal"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recommendations", force: :cascade do |t|
    t.integer  "recommendation_meal_portions"
    t.integer  "recommendation_time_exercise"
    t.integer  "exercise_id"
    t.integer  "meal_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.string   "photo"
    t.integer  "zip"
    t.string   "state"
    t.string   "city"
    t.string   "unit"
    t.string   "street"
    t.string   "password"
    t.string   "username"
    t.integer  "alcohol"
    t.string   "body"
    t.float    "height"
    t.float    "weight"
    t.string   "last_name"
    t.string   "first_name"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "users_inputs", force: :cascade do |t|
    t.integer  "exercise_time"
    t.integer  "exercise_id"
    t.integer  "meal_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "meal"
  end

end
