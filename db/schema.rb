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

ActiveRecord::Schema[8.0].define(version: 2025_11_20_195052) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "deliveries", force: :cascade do |t|
    t.string "tracking_number"
    t.bigint "route_id", null: false
    t.string "status"
    t.datetime "pickup_time"
    t.datetime "delivery_time"
    t.string "recipient_name"
    t.text "recipient_signature"
    t.jsonb "package_details"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["route_id"], name: "index_deliveries_on_route_id"
    t.index ["tracking_number"], name: "index_deliveries_on_tracking_number", unique: true
  end

  create_table "drivers", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "license_number"
    t.string "phone"
    t.string "email"
    t.string "status"
    t.bigint "vehicle_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_drivers_on_email", unique: true
    t.index ["license_number"], name: "index_drivers_on_license_number", unique: true
    t.index ["vehicle_id"], name: "index_drivers_on_vehicle_id"
  end

  create_table "gps_trackings", force: :cascade do |t|
    t.bigint "vehicle_id", null: false
    t.decimal "latitude"
    t.decimal "longitude"
    t.decimal "speed"
    t.integer "heading"
    t.datetime "timestamp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["vehicle_id"], name: "index_gps_trackings_on_vehicle_id"
  end

  create_table "routes", force: :cascade do |t|
    t.string "name"
    t.jsonb "origin"
    t.jsonb "destination"
    t.jsonb "waypoints"
    t.decimal "distance"
    t.integer "estimated_duration"
    t.string "status"
    t.bigint "driver_id", null: false
    t.bigint "vehicle_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["driver_id"], name: "index_routes_on_driver_id"
    t.index ["vehicle_id"], name: "index_routes_on_vehicle_id"
  end

  create_table "telemetries", force: :cascade do |t|
    t.bigint "vehicle_id", null: false
    t.decimal "engine_temp"
    t.decimal "oil_pressure"
    t.decimal "battery_voltage"
    t.jsonb "tire_pressure"
    t.jsonb "diagnostic_codes"
    t.datetime "timestamp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["vehicle_id"], name: "index_telemetries_on_vehicle_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "license_plate"
    t.string "vin"
    t.string "make"
    t.string "model"
    t.integer "year"
    t.string "vehicle_type"
    t.string "status"
    t.jsonb "current_location"
    t.decimal "fuel_level"
    t.integer "mileage"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["license_plate"], name: "index_vehicles_on_license_plate", unique: true
    t.index ["vin"], name: "index_vehicles_on_vin", unique: true
  end

  add_foreign_key "deliveries", "routes"
  add_foreign_key "drivers", "vehicles"
  add_foreign_key "gps_trackings", "vehicles"
  add_foreign_key "routes", "drivers"
  add_foreign_key "routes", "vehicles"
  add_foreign_key "telemetries", "vehicles"
end
