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

ActiveRecord::Schema.define(version: 20180409142008) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "import_jobs", force: :cascade do |t|
    t.string "filepath"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "sku"
    t.string "supplier_code"
    t.string "name"
    t.text "additional_field_1"
    t.text "additional_field_2"
    t.text "additional_field_3"
    t.text "additional_field_4"
    t.text "additional_field_5"
    t.decimal "price", precision: 5, scale: 2, default: "0.0"
    t.index ["sku"], name: "index_products_on_sku", unique: true
    t.index ["supplier_code"], name: "index_products_on_supplier_code"
  end

  create_table "suppliers", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.index ["code"], name: "index_suppliers_on_code", unique: true
  end

end
