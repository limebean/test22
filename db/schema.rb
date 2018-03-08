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

ActiveRecord::Schema.define(version: 20180306113731) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "availabilities", force: :cascade do |t|
    t.bigint "teacher_id"
    t.integer "day_index"
    t.time "start_time"
    t.time "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["teacher_id"], name: "index_availabilities_on_teacher_id"
  end

  create_table "children", force: :cascade do |t|
    t.bigint "teacher_profile_id"
    t.string "full_name", null: false
    t.integer "age", null: false
    t.integer "care_by", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["teacher_profile_id"], name: "index_children_on_teacher_profile_id"
  end

  create_table "teacher_profiles", force: :cascade do |t|
    t.bigint "teacher_id"
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.text "street_address", null: false
    t.string "apt_no"
    t.string "city", null: false
    t.string "home_phone", null: false
    t.string "cell_phone", null: false
    t.date "date_of_birth"
    t.string "language", null: false
    t.string "work"
    t.integer "legal_to_work", null: false
    t.string "floor", default: "", null: false
    t.boolean "condo"
    t.boolean "basement_premises"
    t.boolean "two_exit"
    t.boolean "home_smoke"
    t.boolean "pet"
    t.integer "vaccine", null: false
    t.string "goal"
    t.string "age_range", null: false
    t.boolean "local_school", null: false
    t.string "school_name", null: false
    t.text "comments", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "apartment", default: false
    t.boolean "house", default: false
    t.string "stripe_account_id"
    t.string "profile_image"
    t.string "postal_code"
    t.float "latitude"
    t.float "longitude"
    t.index ["teacher_id"], name: "index_teacher_profiles_on_teacher_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "postal_code"
    t.boolean "approve", default: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "type", null: false
    t.string "invitation_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "telephone_no"
    t.string "last_name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "children", "teacher_profiles"
end
