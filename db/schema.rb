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

ActiveRecord::Schema.define(version: 2021_09_05_131821) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "notes", force: :cascade do |t|
    t.bigint "patient_id", null: false
    t.string "poc"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["patient_id"], name: "index_notes_on_patient_id"
  end

  create_table "patients", force: :cascade do |t|
    t.string "name", null: false
    t.string "avatar"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "practice_words", force: :cascade do |t|
    t.string "name", null: false
    t.string "word_error"
    t.text "additional_info"
    t.bigint "note_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "mispronounced_count", default: 0, null: false
    t.integer "pronounced_count", default: 0, null: false
    t.index ["note_id"], name: "index_practice_words_on_note_id"
  end

  create_table "pronunciations", force: :cascade do |t|
    t.bigint "practice_word_id", null: false
    t.integer "result"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["practice_word_id"], name: "index_pronunciations_on_practice_word_id"
    t.index ["result"], name: "index_pronunciations_on_result"
  end

  add_foreign_key "notes", "patients"
  add_foreign_key "practice_words", "notes"
  add_foreign_key "pronunciations", "practice_words"
end
