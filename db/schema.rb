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

ActiveRecord::Schema.define(version: 20180219121827) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "children", force: :cascade do |t|
    t.bigint "teacher_profile_id"
    t.string "full_name", null: false
    t.integer "age", null: false
    t.boolean "is_family", default: false
    t.boolean "is_private_placed", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["teacher_profile_id"], name: "index_children_on_teacher_profile_id"
  end

  create_table "teacher_profiles", force: :cascade do |t|
    t.bigint "teacher_id"
    t.text "street_address"
    t.string "apt"
    t.string "hear_of_site"
    t.string "home_phone"
    t.string "cell"
    t.string "work"
    t.string "apartment", null: false
    t.string "house", null: false
    t.string "floor"
    t.boolean "is_condo"
    t.boolean "is_two_exits"
    t.boolean "is_basement"
    t.boolean "is_smoking"
    t.boolean "is_pets"
    t.boolean "is_vaccinations"
    t.string "language"
    t.boolean "is_ability_to_work"
    t.boolean "is_legal_to_work"
    t.string "age_range"
    t.boolean "is_local_school"
    t.string "school_name"
    t.string "comments"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["teacher_id"], name: "index_teacher_profiles_on_teacher_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.integer "postal_code", null: false
    t.boolean "is_approve", default: false
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
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "children", "teacher_profiles"
end
