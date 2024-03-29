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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120219150431) do

  create_table "approvals", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "item_id"
    t.integer  "item_pair_id"
  end

  create_table "offers", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "item_id"
    t.integer  "item_offering_id"
  end

  create_table "booksets", :force => true do |t|
    t.string   "description",   :limit => 99
    t.string   "category",      :limit => 20
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "omniuser_id"
    t.integer  "approval_flag",               :default => 0
    t.integer  "offering_flag"
    t.integer  "offered_flag"
  end

  create_table "items", :force => true do |t|
    t.integer  "omniuser_id"
    t.string   "description"
    t.string   "category"
    t.string   "image"
    t.integer  "offered_flag",  :default => 0
    t.integer  "offering_flag", :default => 0
    t.integer  "approval_flag", :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "omniusers", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "omniuser_id"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
