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

ActiveRecord::Schema[7.0].define(version: 2023_07_25_152356) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "excavators", force: :cascade do |t|
    t.bigint "ticket_id"
    t.string "company_name"
    t.string "full_address"
    t.boolean "crew_on_site", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ticket_id"], name: "index_excavators_on_ticket_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.string "request_number", null: false
    t.string "request_type"
    t.string "sequence_number"
    t.string "primary_sa_code"
    t.string "additional_sa_codes", default: [], array: true
    t.text "polygon"
    t.jsonb "external_data", default: {}
    t.datetime "response_due_timestamp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "excavators", "tickets"
end
