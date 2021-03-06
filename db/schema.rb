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

ActiveRecord::Schema.define(:version => 20110603221452) do

  create_table "access_tokens", :force => true do |t|
    t.integer  "user_id"
    t.string   "type",       :limit => 30
    t.string   "key"
    t.string   "token",      :limit => 1024
    t.string   "secret"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "access_tokens", ["key"], :name => "index_access_tokens_on_key", :unique => true

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "token"
    t.string   "secret"
  end

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

  create_table "memberships", :force => true do |t|
    t.integer  "team_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "memberships", ["team_id", "user_id"], :name => "index_memberships_on_team_id_and_user_id", :unique => true
  add_index "memberships", ["team_id"], :name => "index_memberships_on_team_id"
  add_index "memberships", ["user_id"], :name => "index_memberships_on_user_id"

  create_table "microposts", :force => true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "team_id"
  end

  add_index "microposts", ["user_id"], :name => "index_microposts_on_user_id"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "teams", :force => true do |t|
    t.string   "name"
    t.text     "mission"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => ""
    t.string   "reset_password_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "picture_url"
    t.string   "invitation_token",     :limit => 60
    t.datetime "invitation_sent_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["invitation_token"], :name => "index_users_on_invitation_token"
  add_index "users", ["invited_by_id"], :name => "index_users_on_invited_by_id"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
