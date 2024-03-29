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

ActiveRecord::Schema.define(version: 20180714170916) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contacts", force: :cascade do |t|
    t.string "name", null: false
    t.string "phone_number"
    t.string "picture"
    t.bigint "elderly_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["elderly_user_id"], name: "index_contacts_on_elderly_user_id"
  end

  create_table "measurements", force: :cascade do |t|
    t.integer "measurement_type", default: 0, null: false
    t.text "notes"
    t.float "value", null: false
    t.datetime "date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "elderly_user_id"
    t.index ["elderly_user_id"], name: "index_measurements_on_elderly_user_id"
  end

  create_table "personal_medicine_reminders", force: :cascade do |t|
    t.string "name"
    t.text "notes"
    t.datetime "date"
    t.datetime "time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "elderly_user_id"
    t.boolean "taken", default: false
    t.index ["elderly_user_id"], name: "index_personal_medicine_reminders_on_elderly_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "verification_code"
    t.string "type", default: "ElderlyUser"
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.bigint "elderly_user_id"
    t.string "device_token"
    t.bigint "doctor_user_id"
    t.index ["doctor_user_id"], name: "index_users_on_doctor_user_id"
    t.index ["elderly_user_id"], name: "index_users_on_elderly_user_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
