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

ActiveRecord::Schema.define(version: 2020_12_25_225757) do

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

  create_table "enterprises", force: :cascade do |t|
    t.string "description"
    t.string "primary_color"
    t.string "secondary_color"
    t.string "instagram"
    t.string "twitch"
    t.string "whatsapp_group"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "skins", force: :cascade do |t|
    t.bigint "id_steam", null: false
    t.string "description", null: false
    t.string "description_color", null: false
    t.string "exterior"
    t.string "image_skin"
    t.float "float", null: false
    t.float "price_steam", default: 0.0
    t.float "first_price_steam", default: 0.0
    t.float "price_csmoney", default: 0.0
    t.float "price_paid", default: 0.0
    t.float "sale_price", default: 0.0
    t.boolean "is_stattrak", default: false
    t.boolean "has_sticker", default: false
    t.text "name_sticker", default: [], array: true
    t.text "image_sticker", default: [], array: true
    t.boolean "is_available", default: true
    t.datetime "expiration_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "inspect_url"
    t.bigint "transaction_id"
    t.bigint "steam_account_id"
    t.string "type_skin"
    t.string "type_weapon"
    t.index ["id_steam"], name: "index_skins_on_id_steam", unique: true
    t.index ["steam_account_id"], name: "index_skins_on_steam_account_id"
    t.index ["transaction_id"], name: "index_skins_on_transaction_id"
  end

  create_table "steam_accounts", force: :cascade do |t|
    t.string "description"
    t.bigint "steam_id", null: false
    t.string "url", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["steam_id"], name: "index_steam_accounts_on_steam_id", unique: true
    t.index ["url"], name: "index_steam_accounts_on_url", unique: true
    t.index ["user_id"], name: "index_steam_accounts_on_user_id"
  end

  create_table "transaction_types", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["description"], name: "index_transaction_types_on_description", unique: true
  end

  create_table "transactions", force: :cascade do |t|
    t.string "description"
    t.float "price"
    t.bigint "transaction_type_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id"
    t.index ["transaction_type_id"], name: "index_transactions_on_transaction_type_id"
    t.index ["user_id"], name: "index_transactions_on_user_id"
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
    t.string "ddi"
    t.string "cell_phone"
    t.boolean "is_whatsapp", default: false
    t.bigint "enterprise_id"
    t.boolean "is_super_admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["enterprise_id"], name: "index_users_on_enterprise_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "skins", "steam_accounts"
  add_foreign_key "skins", "transactions"
  add_foreign_key "steam_accounts", "users"
  add_foreign_key "transactions", "transaction_types"
  add_foreign_key "transactions", "users"
  add_foreign_key "users", "enterprises"
end
