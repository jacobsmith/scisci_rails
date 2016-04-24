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

ActiveRecord::Schema.define(version: 20140408015655) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "collaborators", force: true do |t|
    t.integer "project_id"
    t.integer "user_id"
  end

  add_index "collaborators", ["project_id"], name: "index_collaborators_on_project_id", using: :btree
  add_index "collaborators", ["user_id"], name: "index_collaborators_on_user_id", using: :btree

  create_table "notes", force: true do |t|
    t.text     "quote"
    t.text     "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "source_id"
    t.integer  "project_id"
    t.integer  "user_id"
  end

  add_index "notes", ["source_id"], name: "index_notes_on_source_id", using: :btree

  create_table "projects", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user_id"
    t.integer  "collaborators"
    t.integer  "section_id"
    t.integer  "section_project_id"
    t.integer  "teacher_id"
    t.boolean  "collaboratable",        default: false
    t.text     "student_defined_title"
    t.text     "thesis"
    t.text     "due_date"
    t.boolean  "can_change_due_date",   default: false
  end

  add_index "projects", ["user_id"], name: "index_projects_on_user_id", using: :btree

  create_table "sections", force: true do |t|
    t.string   "teacher_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "owner_id"
  end

  create_table "sessions", force: true do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "sources", force: true do |t|
    t.string   "title"
    t.string   "authors"
    t.string   "url"
    t.text     "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "project_id"
    t.string   "city_of_publication"
    t.string   "year_of_publication"
    t.string   "publisher"
    t.string   "medium"
    t.string   "title_of_article"
    t.string   "title_of_periodical"
    t.string   "publication_date"
    t.string   "pages"
    t.string   "name_of_site"
    t.string   "name_of_organization"
    t.string   "date_of_creation"
    t.string   "date_of_access"
    t.string   "source_type"
    t.string   "image_url"
    t.integer  "user_id"
  end

  add_index "sources", ["project_id"], name: "index_sources_on_project_id", using: :btree

  create_table "student_section_relations", force: true do |t|
    t.integer "section_id"
    t.integer "user_id"
  end

  create_table "tags", force: true do |t|
    t.string   "name"
    t.string   "note_id"
    t.string   "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "color"
    t.integer  "user_id"
  end

  create_table "teachers", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",        null: false
    t.string   "encrypted_password",     default: "",        null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,         null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.integer  "collaborators"
    t.boolean  "searchable"
    t.string   "non_sti_type",           default: "Student"
    t.integer  "school_system_id",       default: 0
  end

  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
