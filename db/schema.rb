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

ActiveRecord::Schema.define(version: 20170521131629) do

  create_table "Projects_Users", id: false, force: :cascade do |t|
    t.integer "User_id", null: false
    t.integer "Project_id", null: false
    t.index ["Project_id", "User_id"], name: "index_Projects_Users_on_project_id_and_user_id"
    t.index ["User_id", "Project_id"], name: "index_Projects_Users_on_user_id_and_project_id"
  end

  create_table "comments", force: :cascade do |t|
    t.integer "requirement_id"
    t.integer "user_id"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["requirement_id"], name: "index_comments_on_requirement_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "glosarios", force: :cascade do |t|
    t.string "key"
    t.string "definition"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["key"], name: "index_glosarios_on_key", unique: true
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.string "client"
    t.date "start_date"
    t.date "finish_date"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_projects_on_name"
  end

  create_table "requirements", force: :cascade do |t|
    t.integer "project_id"
    t.integer "user_id"
    t.text "description"
    t.string "sufix"
    t.string "status"
    t.string "category"
    t.date "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_requirements_on_project_id"
    t.index ["user_id"], name: "index_requirements_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
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
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
