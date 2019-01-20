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

ActiveRecord::Schema.define(version: 20190120004240) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bots", force: :cascade do |t|
    t.string "verify_token"
    t.string "access_token"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "page_id"
    t.string "name"
    t.index ["user_id"], name: "index_bots_on_user_id"
  end

  create_table "flow_sessions", force: :cascade do |t|
    t.string "sender_id"
    t.bigint "flow_id"
    t.bigint "current_state_id"
    t.bigint "next_state_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["current_state_id"], name: "index_flow_sessions_on_current_state_id"
    t.index ["flow_id"], name: "index_flow_sessions_on_flow_id"
    t.index ["next_state_id"], name: "index_flow_sessions_on_next_state_id"
  end

  create_table "flows", force: :cascade do |t|
    t.bigint "bot_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["bot_id"], name: "index_flows_on_bot_id"
  end

  create_table "pages", force: :cascade do |t|
    t.string "access_token", null: false
    t.string "category", null: false
    t.string "name", null: false
    t.string "facebook_id", null: false
    t.text "category_list", default: [], array: true
    t.text "tasks", default: [], array: true
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_pages_on_user_id"
  end

  create_table "question_states", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.text "question"
  end

  create_table "states", force: :cascade do |t|
    t.bigint "flow_id"
    t.string "statable_type"
    t.bigint "statable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["flow_id"], name: "index_states_on_flow_id"
    t.index ["statable_type", "statable_id"], name: "index_states_on_statable_type_and_statable_id"
  end

  create_table "text_states", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "text"
  end

  create_table "users", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "name"
    t.string "nickname"
    t.string "image"
    t.string "email"
    t.json "tokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.json "social_access_tokens"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  add_foreign_key "bots", "users"
  add_foreign_key "flow_sessions", "flows"
  add_foreign_key "flow_sessions", "states", column: "current_state_id"
  add_foreign_key "flow_sessions", "states", column: "next_state_id"
  add_foreign_key "flows", "bots"
  add_foreign_key "states", "flows"
end
