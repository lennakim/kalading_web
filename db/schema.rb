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

ActiveRecord::Schema.define(version: 20141208170232) do

  create_table "messages", force: true do |t|
    t.string   "to_user_name"
    t.string   "from_user_name"
    t.string   "create_time"
    t.string   "msg_type"
    t.text     "contnet"
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
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messages", ["user_id"], name: "index_messages_on_user_id", using: :btree

  create_table "public_accounts", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "weixin_secret_key"
    t.string   "weixin_token"
    t.string   "weixin_id"
    t.string   "appid"
    t.string   "appsecret"
  end

  add_index "public_accounts", ["weixin_id"], name: "index_public_accounts_on_weixin_id", unique: true, using: :btree
  add_index "public_accounts", ["weixin_secret_key"], name: "index_public_accounts_on_weixin_secret_key", using: :btree
  add_index "public_accounts", ["weixin_token"], name: "index_public_accounts_on_weixin_token", using: :btree

  create_table "users", force: true do |t|
    t.integer  "subscribe"
    t.string   "openid"
    t.string   "nickname"
    t.integer  "sex"
    t.string   "city"
    t.string   "country"
    t.string   "province"
    t.string   "language"
    t.string   "headimgurl"
    t.datetime "subscribe_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "publicaccount_id"
  end

end
