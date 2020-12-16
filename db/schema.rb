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

ActiveRecord::Schema.define(version: 2020_12_16_171126) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "citext"
  enable_extension "plpgsql"

  create_table "bearers", force: :cascade do |t|
    t.citext "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_bearers_on_name", unique: true
  end

  create_table "stocks", force: :cascade do |t|
    t.citext "name"
    t.datetime "deleted_at"
    t.bigint "bearer_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["bearer_id"], name: "index_stocks_on_bearer_id"
    t.index ["name"], name: "index_stocks_on_name", unique: true
  end

  add_foreign_key "stocks", "bearers"
end
