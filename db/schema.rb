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

ActiveRecord::Schema.define(version: 2020_10_09_022719) do

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
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "item_types", force: :cascade do |t|
    t.string "description", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["description"], name: "index_item_types_on_description", unique: true
  end

  create_table "skin_exteriors", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["description"], name: "index_skin_exteriors_on_description", unique: true
  end

  create_table "skin_types", force: :cascade do |t|
    t.string "description"
    t.bigint "item_type_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["description"], name: "index_skin_types_on_description", unique: true
    t.index ["item_type_id"], name: "index_skin_types_on_item_type_id"
  end

  create_table "skins", force: :cascade do |t|
    t.string "description", null: false
    t.float "float", null: false
    t.float "price_steam", null: false
    t.float "price_csmoney", null: false
    t.float "price_paid", null: false
    t.float "sale_price", null: false
    t.boolean "is_stattrak", default: false
    t.boolean "has_sticker", default: false
    t.boolean "is_available", default: true
    t.bigint "item_type_id", null: false
    t.bigint "skin_type_id", null: false
    t.bigint "skin_exterior_id", null: false
    t.bigint "transaction_type_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["description"], name: "index_skins_on_description", unique: true
    t.index ["item_type_id"], name: "index_skins_on_item_type_id"
    t.index ["skin_exterior_id"], name: "index_skins_on_skin_exterior_id"
    t.index ["skin_type_id"], name: "index_skins_on_skin_type_id"
    t.index ["transaction_type_id"], name: "index_skins_on_transaction_type_id"
  end

  create_table "transaction_types", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["description"], name: "index_transaction_types_on_description", unique: true
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
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "first_name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.string "nickname", default: "", null: false
    t.boolean "is_admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "skin_types", "item_types"
  add_foreign_key "skins", "item_types"
  add_foreign_key "skins", "skin_exteriors"
  add_foreign_key "skins", "skin_types"
  add_foreign_key "skins", "transaction_types"
end
