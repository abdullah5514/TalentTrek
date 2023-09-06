# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2023_09_06_121931) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authors", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "speciality"
    t.string "email"
    t.string "phone"
  end

  create_table "courses", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "author_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "talent_id", null: false
    t.string "instructor_type"
    t.bigint "instructor_id"
    t.string "course_code"
    t.string "status"
    t.index ["instructor_type", "instructor_id"], name: "index_courses_on_instructor_type_and_instructor_id"
    t.index ["talent_id"], name: "index_courses_on_talent_id"
  end

  create_table "courses_learning_paths", id: false, force: :cascade do |t|
    t.bigint "course_id"
    t.bigint "learning_path_id"
    t.index ["course_id"], name: "index_courses_learning_paths_on_course_id"
    t.index ["learning_path_id"], name: "index_courses_learning_paths_on_learning_path_id"
  end

  create_table "courses_talents", id: false, force: :cascade do |t|
    t.bigint "course_id"
    t.bigint "talent_id"
    t.index ["course_id"], name: "index_courses_talents_on_course_id"
    t.index ["talent_id"], name: "index_courses_talents_on_talent_id"
  end

  create_table "learning_paths", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "course_sequence", default: [], array: true
    t.date "start_date"
    t.date "end_date"
    t.string "title"
    t.string "status"
  end

  create_table "learning_paths_talents", id: false, force: :cascade do |t|
    t.bigint "learning_path_id"
    t.bigint "talent_id"
    t.index ["learning_path_id"], name: "index_learning_paths_talents_on_learning_path_id"
    t.index ["talent_id"], name: "index_learning_paths_talents_on_talent_id"
  end

  create_table "talents", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "roll_no"
    t.string "email"
    t.string "phone"
  end

  add_foreign_key "courses", "talents"
end
