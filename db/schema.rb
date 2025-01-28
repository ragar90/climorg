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

ActiveRecord::Schema.define(version: 20250127232813) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.integer  "result_id"
    t.integer  "question_id"
    t.integer  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "companies", force: :cascade do |t|
    t.string   "name"
    t.integer  "city_id"
    t.integer  "state_id"
    t.integer  "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "countries", force: :cascade do |t|
    t.string   "name"
    t.string   "iso"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "demographic_settings", force: :cascade do |t|
    t.integer  "research_id"
    t.integer  "demographic_variable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "demographic_values", force: :cascade do |t|
    t.integer  "demographic_variable_id"
    t.integer  "result_id"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "demographic_variables", force: :cascade do |t|
    t.string   "name"
    t.boolean  "is_default"
    t.string   "display_values"
    t.string   "accepted_value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.boolean  "is_active",      default: true
  end

  create_table "dimension_settings", force: :cascade do |t|
    t.integer  "research_id"
    t.integer  "dimension_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dimensions", force: :cascade do |t|
    t.string   "name"
    t.boolean  "is_default"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.boolean  "is_active",  default: true
  end

  create_table "employees", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.boolean  "has_evaluated_research", default: false
    t.integer  "organization_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "evaluations", force: :cascade do |t|
    t.integer  "research_id"
    t.integer  "employee_id"
    t.boolean  "done",         default: false
    t.integer  "result_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "access_token"
    t.date     "access_sent"
  end

  create_table "organizations", force: :cascade do |t|
    t.string   "name"
    t.string   "logo"
    t.integer  "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string   "description"
    t.integer  "dimension_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "research_id"
    t.integer  "ordinal"
    t.boolean  "is_active",    default: true
  end

  create_table "researches", force: :cascade do |t|
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "state",                   default: 0
    t.boolean  "is_conclude",             default: false
    t.integer  "user_id"
    t.integer  "organization_id"
    t.boolean  "use_virtual_application", default: true
  end

  create_table "results", force: :cascade do |t|
    t.integer  "research_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "correlative"
    t.integer  "evaluation_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "avatar"
    t.string   "name"
    t.string   "lastname"
    t.integer  "company_id"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
