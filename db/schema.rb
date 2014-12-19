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

ActiveRecord::Schema.define(version: 20141219070036) do

  create_table "activities", force: true do |t|
    t.string   "name"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "impressions_count", default: 0
  end

  create_table "auth_infos", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "token"
    t.datetime "expires_at"
    t.integer  "public_account_id"
  end

  add_index "auth_infos", ["uid"], name: "index_auth_infos_on_uid", using: :btree

  create_table "channels", force: true do |t|
    t.string   "name"
    t.string   "key"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "diymenus", force: true do |t|
    t.integer  "public_account_id"
    t.integer  "parent_id"
    t.string   "name"
    t.string   "key"
    t.string   "url"
    t.boolean  "is_show"
    t.integer  "sort"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "diymenus", ["key"], name: "index_diymenus_on_key", using: :btree
  add_index "diymenus", ["parent_id"], name: "index_diymenus_on_parent_id", using: :btree
  add_index "diymenus", ["public_account_id"], name: "index_diymenus_on_public_account_id", using: :btree

  create_table "impressions", force: true do |t|
    t.string   "impressionable_type"
    t.integer  "impressionable_id"
    t.integer  "user_id"
    t.string   "controller_name"
    t.string   "action_name"
    t.string   "view_name"
    t.string   "request_hash"
    t.string   "ip_address"
    t.string   "session_hash"
    t.text     "message"
    t.text     "referrer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "impressions", ["controller_name", "action_name", "ip_address"], name: "controlleraction_ip_index", using: :btree
  add_index "impressions", ["controller_name", "action_name", "request_hash"], name: "controlleraction_request_index", using: :btree
  add_index "impressions", ["controller_name", "action_name", "session_hash"], name: "controlleraction_session_index", using: :btree
  add_index "impressions", ["impressionable_type", "impressionable_id", "ip_address"], name: "poly_ip_index", using: :btree
  add_index "impressions", ["impressionable_type", "impressionable_id", "request_hash"], name: "poly_request_index", using: :btree
  add_index "impressions", ["impressionable_type", "impressionable_id", "session_hash"], name: "poly_session_index", using: :btree
  add_index "impressions", ["impressionable_type", "message", "impressionable_id"], name: "impressionable_type_message_index", length: {"impressionable_type"=>nil, "message"=>255, "impressionable_id"=>nil}, using: :btree
  add_index "impressions", ["user_id"], name: "index_impressions_on_user_id", using: :btree

  create_table "messages", force: true do |t|
    t.string   "to_user_name"
    t.string   "from_user_name"
    t.string   "create_time"
    t.string   "msg_type"
    t.text     "content"
    t.string   "msg_id"
    t.string   "pic_url"
    t.string   "media_id"
    t.string   "format"
    t.string   "thumb_media_id"
    t.string   "location_x"
    t.string   "location_y"
    t.string   "scale"
    t.string   "label"
    t.string   "title"
    t.text     "description"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messages", ["msg_id"], name: "index_messages_on_msg_id", unique: true, using: :btree

  create_table "public_accounts", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "account_secret_key"
    t.string   "account_token"
    t.string   "account_id"
    t.string   "appid"
    t.string   "appsecret"
    t.string   "name"
  end

  add_index "public_accounts", ["account_id"], name: "index_public_accounts_on_account_id", unique: true, using: :btree
  add_index "public_accounts", ["account_secret_key"], name: "index_public_accounts_on_account_secret_key", using: :btree
  add_index "public_accounts", ["account_token"], name: "index_public_accounts_on_account_token", using: :btree
  add_index "public_accounts", ["name"], name: "index_public_accounts_on_name", unique: true, using: :btree

  create_table "user_authinfos", force: true do |t|
    t.integer  "user_id"
    t.integer  "auth_info_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "token"
    t.string   "phone_number"
  end

  add_index "users", ["token"], name: "index_users_on_token", using: :btree

  create_table "verification_codes", force: true do |t|
    t.string   "phone_num"
    t.string   "code"
    t.datetime "expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "verification_codes", ["code"], name: "index_verification_codes_on_code", using: :btree
  add_index "verification_codes", ["phone_num"], name: "index_verification_codes_on_phone_num", using: :btree

end
