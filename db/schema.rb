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

ActiveRecord::Schema.define(version: 20170524222725) do

  create_table "comments", force: :cascade do |t|
    t.integer "requirement_id"
    t.integer "user_id"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["requirement_id"], name: "index_comments_on_requirement_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "glossaries", force: :cascade do |t|
    t.integer "project_id"
    t.string "key"
    t.string "definition"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_glossaries_on_project_id"
  end

  create_table "logs", force: :cascade do |t|
    t.integer "project_id"
    t.integer "user_id"
    t.text "operation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_logs_on_project_id"
    t.index ["user_id"], name: "index_logs_on_user_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.string "client"
    t.date "end_date"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "picture_file_name"
    t.string "picture_content_type"
    t.integer "picture_file_size"
    t.datetime "picture_updated_at"
  end

  create_table "requirements", force: :cascade do |t|
    t.integer "project_id"
    t.integer "user_id"
    t.string "suffix"
    t.text "description"
    t.string "status"
    t.date "end_date"
    t.string "category"
    t.string "level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_requirements_on_project_id"
    t.index ["user_id"], name: "index_requirements_on_user_id"
  end

  create_table "user_projects", force: :cascade do |t|
    t.integer "project_id"
    t.integer "user_id"
    t.boolean "owner", default: false, null: false
    t.index ["project_id"], name: "index_user_projects_on_project_id"
    t.index ["user_id"], name: "index_user_projects_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "role"
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.integer "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
