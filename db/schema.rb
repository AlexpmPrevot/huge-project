# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_06_01_112832) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "hugs", force: :cascade do |t|
    t.bigint "sender_id"
    t.bigint "receiver_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "progress"
    t.index ["receiver_id"], name: "index_hugs_on_receiver_id"
    t.index ["sender_id"], name: "index_hugs_on_sender_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "rating"
    t.bigint "target_id"
    t.bigint "reviewer_id"
    t.bigint "hug_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["hug_id"], name: "index_reviews_on_hug_id"
    t.index ["reviewer_id"], name: "index_reviews_on_reviewer_id"
    t.index ["target_id"], name: "index_reviews_on_target_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "nickname"
    t.string "avatar_color", default: "#3D3D3D"
    t.integer "score", default: 0
    t.string "city"
    t.text "bio"
    t.float "latitude"
    t.float "longitude"
    t.datetime "last_request_at"
    t.boolean "logged_in", default: false
    t.string "avatar"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "hugs", "users", column: "receiver_id"
  add_foreign_key "hugs", "users", column: "sender_id"
  add_foreign_key "reviews", "hugs"
  add_foreign_key "reviews", "users", column: "reviewer_id"
  add_foreign_key "reviews", "users", column: "target_id"
end
