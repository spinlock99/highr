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

ActiveRecord::Schema.define(:version => 20110328162454) do

  create_table "hartman_value_profiles", :force => true do |t|
    t.datetime "taken_at"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "dif_v"
    t.integer  "dim_i_v"
    t.integer  "dim_e_v"
    t.integer  "dim_s_v"
    t.integer  "int_v"
    t.integer  "int_i_v"
    t.integer  "int_e_v"
    t.integer  "int_s_v"
    t.integer  "dim_v"
    t.integer  "di_v"
    t.integer  "dis_v"
    t.float    "dim_percent_v"
    t.float    "int_percent_v"
    t.integer  "positive_i_v"
    t.integer  "positive_e_v"
    t.integer  "positive_s_v"
    t.integer  "positive_total_v"
    t.integer  "negative_i_v"
    t.integer  "negative_e_v"
    t.integer  "negative_s_v"
    t.integer  "negative_total_v"
    t.float    "ai_percent_v"
    t.integer  "dif_s"
    t.integer  "dim_i_s"
    t.integer  "dim_e_s"
    t.integer  "dim_s_s"
    t.integer  "int_s"
    t.integer  "int_i_s"
    t.integer  "int_e_s"
    t.integer  "int_s_s"
    t.integer  "dim_s"
    t.integer  "di_s"
    t.integer  "dis_s"
    t.float    "dim_percent_s"
    t.float    "int_percent_s"
    t.integer  "positive_i_s"
    t.integer  "positive_e_s"
    t.integer  "positive_s_s"
    t.integer  "positive_total_s"
    t.integer  "negative_i_s"
    t.integer  "negative_e_s"
    t.integer  "negative_s_s"
    t.integer  "negative_total_s"
    t.float    "ai_percent_s"
    t.integer  "vq_left"
    t.integer  "vq_right"
    t.integer  "sq_left"
    t.integer  "sq_right"
    t.float    "bqr1"
    t.float    "bqa1"
    t.float    "bqr2"
    t.float    "bqa2"
    t.float    "cq1"
    t.float    "cq2"
    t.float    "dif1_over_dif2"
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
    t.string   "phrase"
  end

  add_index "hvp_elements", ["hartman_value_profile_id"], :name => "index_hvp_elements_on_hartman_value_profile_id"

  create_table "hvp_masters", :force => true do |t|
    t.integer  "axiological_norm"
    t.string   "part_id"
    t.string   "category_id"
    t.string   "phrase"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
