# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2026_05_11_142305) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contact_messages", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "message_type"
    t.text "body"
    t.integer "tool_id"
    t.boolean "read", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "course_episodes", force: :cascade do |t|
    t.string "title"
    t.string "youtube_url"
    t.string "youtube_id"
    t.integer "duration_seconds"
    t.integer "position"
    t.bigint "course_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_course_episodes_on_course_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.boolean "is_series"
    t.bigint "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["category_id"], name: "index_courses_on_category_id"
    t.index ["slug"], name: "index_courses_on_slug", unique: true
  end

  create_table "favorite_courses", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "course_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_favorite_courses_on_course_id"
    t.index ["user_id", "course_id"], name: "index_favorite_courses_on_user_id_and_course_id", unique: true
    t.index ["user_id"], name: "index_favorite_courses_on_user_id"
  end

  create_table "favorite_tools", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "tool_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tool_id"], name: "index_favorite_tools_on_tool_id"
    t.index ["user_id", "tool_id"], name: "index_favorite_tools_on_user_id_and_tool_id", unique: true
    t.index ["user_id"], name: "index_favorite_tools_on_user_id"
  end

  create_table "featured_items", force: :cascade do |t|
    t.bigint "tool_id", null: false
    t.date "featured_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tool_id", "featured_on"], name: "index_featured_items_on_tool_id_and_featured_on", unique: true
    t.index ["tool_id"], name: "index_featured_items_on_tool_id"
  end

  create_table "tools", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "website_url"
    t.string "slug"
    t.boolean "open_source"
    t.boolean "free_tier"
    t.string "platform"
    t.string "level"
    t.bigint "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_tools_on_category_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false, null: false
    t.string "provider"
    t.string "uid"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["provider", "uid"], name: "index_users_on_provider_and_uid", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "video_progresses", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "course_episode_id", null: false
    t.integer "seconds_watched", default: 0
    t.boolean "completed", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_episode_id"], name: "index_video_progresses_on_course_episode_id"
    t.index ["user_id", "course_episode_id"], name: "index_video_progresses_on_user_id_and_course_episode_id", unique: true
    t.index ["user_id"], name: "index_video_progresses_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "course_episodes", "courses"
  add_foreign_key "courses", "categories"
  add_foreign_key "favorite_courses", "courses"
  add_foreign_key "favorite_courses", "users"
  add_foreign_key "favorite_tools", "tools"
  add_foreign_key "favorite_tools", "users"
  add_foreign_key "featured_items", "tools"
  add_foreign_key "tools", "categories"
  add_foreign_key "video_progresses", "course_episodes"
  add_foreign_key "video_progresses", "users"
end
