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

ActiveRecord::Schema.define(version: 20180322103835) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_infos", force: :cascade do |t|
    t.string "name"
    t.string "document"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

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
    t.integer "age"
    t.integer "care_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "date_of_birth"
    t.string "place_of_birth"
    t.bigint "parent_id"
    t.string "gender"
    t.string "allergies"
    t.string "medication"
    t.string "medical_condition"
    t.index ["parent_id"], name: "index_children_on_parent_id"
    t.index ["teacher_profile_id"], name: "index_children_on_teacher_profile_id"
  end

  create_table "enrollments", force: :cascade do |t|
    t.bigint "child_id"
    t.bigint "teacher_id"
    t.string "start_date"
    t.string "weekdays_and_time"
    t.string "other_comments"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "status", default: false
    t.index ["child_id"], name: "index_enrollments_on_child_id"
    t.index ["teacher_id"], name: "index_enrollments_on_teacher_id"
  end

  create_table "favourites", force: :cascade do |t|
    t.bigint "parent_id"
    t.bigint "teacher_id"
    t.boolean "status", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parent_id"], name: "index_favourites_on_parent_id"
    t.index ["teacher_id"], name: "index_favourites_on_teacher_id"
  end

  create_table "parent_profiles", force: :cascade do |t|
    t.string "guardian_name"
    t.string "guardian_email"
    t.string "guardian_occupation"
    t.string "guardian_phone"
    t.string "second_guardian_name"
    t.string "second_guardian_email"
    t.string "second_guardian_phone"
    t.string "child_name"
    t.date "child_date_of_birth"
    t.date "start_of_care"
    t.string "end_of_care"
    t.string "weekly_schedule"
    t.string "past_child_care"
    t.string "child_eat_habits"
    t.string "child_sleep_habits"
    t.string "describe_child"
    t.string "child_temperament"
    t.string "behavioral_situation"
    t.string "factor_to_enroll"
    t.string "child_accomodation_needs"
    t.string "recent_reaction"
    t.string "school_meeting_concern"
    t.string "hear_about_us"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "parent_id"
    t.string "second_guardian_occupation"
    t.string "desired_schedule"
  end

  create_table "payments", force: :cascade do |t|
    t.bigint "parent_id"
    t.bigint "teacher_id"
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parent_id"], name: "index_payments_on_parent_id"
    t.index ["teacher_id"], name: "index_payments_on_teacher_id"
  end

  create_table "prices", force: :cascade do |t|
    t.bigint "teacher_id"
    t.integer "child_time"
    t.float "two_days_price"
    t.float "three_days_price"
    t.float "five_days_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["teacher_id"], name: "index_prices_on_teacher_id"
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
    t.string "cover_photo"
    t.boolean "request_info", default: false
    t.boolean "tour", default: false
    t.boolean "open_house", default: false
    t.float "transaction_fee"
    t.index ["teacher_id"], name: "index_teacher_profiles_on_teacher_id"
  end

  create_table "tour_requests", force: :cascade do |t|
    t.bigint "teacher_id"
    t.date "tour_date"
    t.time "tour_time"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["teacher_id"], name: "index_tour_requests_on_teacher_id"
    t.index ["user_id"], name: "index_tour_requests_on_user_id"
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
    t.string "stripe_customer_id"
    t.date "expiry_date"
    t.boolean "active"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "children", "teacher_profiles"
  add_foreign_key "tour_requests", "users"
end
