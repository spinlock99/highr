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

ActiveRecord::Schema.define(:version => 20110321173651) do

  create_table "hartman_value_profiles", :force => true do |t|
    t.datetime "taken_at"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hartman_value_profiles", ["user_id"], :name => "index_hartman_value_profiles_on_user_id"

  create_table "hvp_elements", :force => true do |t|
    t.integer  "axiological_norm"
    t.integer  "given_value"
    t.string   "part_id"
    t.string   "category_id"
    t.integer  "hartman_value_profile_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hvp_elements", ["hartman_value_profile_id"], :name => "index_hvp_elements_on_hartman_value_profile_id"

  create_table "microposts", :force => true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "microposts", ["user_id"], :name => "index_microposts_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.boolean  "admin",             :default => false
    t.string   "persistence_token"
    t.string   "oauth_token"
    t.string   "oauth_secret"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["oauth_token"], :name => "index_users_on_oauth_token"

end
