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

ActiveRecord::Schema.define(version: 2021_09_21_132247) do

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

  create_table "add_on_groups", force: :cascade do |t|
    t.string "name"
    t.bigint "seller_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["seller_id"], name: "index_add_on_groups_on_seller_id"
  end

  create_table "add_ons", force: :cascade do |t|
    t.float "price"
    t.string "name"
    t.bigint "add_on_group_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["add_on_group_id"], name: "index_add_ons_on_add_on_group_id"
  end

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "buyer_payment_methods", force: :cascade do |t|
    t.bigint "buyer_id", null: false
    t.bigint "payment_method_id", null: false
    t.boolean "selected", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["buyer_id"], name: "index_buyer_payment_methods_on_buyer_id"
    t.index ["payment_method_id"], name: "index_buyer_payment_methods_on_payment_method_id"
  end

  create_table "buyers", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "name"
    t.string "nickname"
    t.string "image"
    t.string "email"
    t.json "tokens"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "first_name"
    t.string "last_name"
    t.string "phone_number"
    t.index ["confirmation_token"], name: "index_buyers_on_confirmation_token", unique: true
    t.index ["email"], name: "index_buyers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_buyers_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_buyers_on_uid_and_provider", unique: true
  end

  create_table "cart_add_ons", force: :cascade do |t|
    t.bigint "cart_id", null: false
    t.bigint "add_on_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["add_on_id"], name: "index_cart_add_ons_on_add_on_id"
    t.index ["cart_id"], name: "index_cart_add_ons_on_cart_id"
  end

  create_table "carts", force: :cascade do |t|
    t.bigint "buyer_id", null: false
    t.bigint "product_id", null: false
    t.bigint "seller_id", null: false
    t.integer "quantity"
    t.bigint "product_price_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "total"
    t.index ["buyer_id"], name: "index_carts_on_buyer_id"
    t.index ["product_id"], name: "index_carts_on_product_id"
    t.index ["product_price_id"], name: "index_carts_on_product_price_id"
    t.index ["seller_id"], name: "index_carts_on_seller_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.integer "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "category_deals", force: :cascade do |t|
    t.bigint "category_id", null: false
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_category_deals_on_category_id"
  end

  create_table "checkout_add_ons", force: :cascade do |t|
    t.bigint "checkout_product_id", null: false
    t.bigint "add_on_id", null: false
    t.string "name"
    t.float "price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["add_on_id"], name: "index_checkout_add_ons_on_add_on_id"
    t.index ["checkout_product_id"], name: "index_checkout_add_ons_on_checkout_product_id"
  end

  create_table "checkout_products", force: :cascade do |t|
    t.bigint "checkout_seller_id", null: false
    t.bigint "product_id", null: false
    t.bigint "product_price_id", null: false
    t.string "size"
    t.float "price"
    t.integer "quantity"
    t.float "total"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["checkout_seller_id"], name: "index_checkout_products_on_checkout_seller_id"
    t.index ["product_id"], name: "index_checkout_products_on_product_id"
    t.index ["product_price_id"], name: "index_checkout_products_on_product_price_id"
  end

  create_table "checkout_sellers", force: :cascade do |t|
    t.bigint "checkout_id", null: false
    t.bigint "seller_id", null: false
    t.float "delivery_fee"
    t.float "total"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status", default: 0
    t.index ["checkout_id"], name: "index_checkout_sellers_on_checkout_id"
    t.index ["seller_id"], name: "index_checkout_sellers_on_seller_id"
  end

  create_table "checkouts", force: :cascade do |t|
    t.bigint "buyer_id", null: false
    t.float "total"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "latitude"
    t.float "longitude"
    t.string "details"
    t.bigint "payment_method_id", null: false
    t.index ["buyer_id"], name: "index_checkouts_on_buyer_id"
    t.index ["payment_method_id"], name: "index_checkouts_on_payment_method_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "user_type", null: false
    t.bigint "user_id", null: false
    t.string "name"
    t.float "longitude"
    t.float "latitude"
    t.string "details"
    t.string "street"
    t.string "city"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "village"
    t.string "state"
    t.boolean "selected", default: false
    t.index ["user_type", "user_id"], name: "index_locations_on_user_type_and_user_id"
  end

  create_table "payment_methods", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "product_add_ons", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.bigint "add_on_group_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "require", default: 0
    t.integer "num_of_select", default: 1
    t.index ["add_on_group_id"], name: "index_product_add_ons_on_add_on_group_id"
    t.index ["product_id"], name: "index_product_add_ons_on_product_id"
  end

  create_table "product_categories", force: :cascade do |t|
    t.string "name"
    t.bigint "seller_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["seller_id"], name: "index_product_categories_on_seller_id"
  end

  create_table "product_prices", force: :cascade do |t|
    t.float "price"
    t.bigint "product_id", null: false
    t.bigint "product_size_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id"], name: "index_product_prices_on_product_id"
    t.index ["product_size_id"], name: "index_product_prices_on_product_size_id"
  end

  create_table "product_sizes", force: :cascade do |t|
    t.string "name"
    t.bigint "seller_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["seller_id"], name: "index_product_sizes_on_seller_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.bigint "product_category_id", null: false
    t.bigint "seller_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "description"
    t.index ["product_category_id"], name: "index_products_on_product_category_id"
    t.index ["seller_id"], name: "index_products_on_seller_id"
  end

  create_table "sellers", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "name"
    t.string "nickname"
    t.string "email"
    t.json "tokens"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "phone_number"
    t.bigint "category_id", null: false
    t.string "address"
    t.integer "num_of_completed_checkouts", default: 0
    t.index ["category_id"], name: "index_sellers_on_category_id"
    t.index ["confirmation_token"], name: "index_sellers_on_confirmation_token", unique: true
    t.index ["email"], name: "index_sellers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_sellers_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_sellers_on_uid_and_provider", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "add_on_groups", "sellers"
  add_foreign_key "add_ons", "add_on_groups"
  add_foreign_key "buyer_payment_methods", "buyers"
  add_foreign_key "buyer_payment_methods", "payment_methods"
  add_foreign_key "cart_add_ons", "add_ons"
  add_foreign_key "cart_add_ons", "carts"
  add_foreign_key "carts", "buyers"
  add_foreign_key "carts", "product_prices"
  add_foreign_key "carts", "products"
  add_foreign_key "carts", "sellers"
  add_foreign_key "category_deals", "categories"
  add_foreign_key "checkout_add_ons", "add_ons"
  add_foreign_key "checkout_add_ons", "checkout_products"
  add_foreign_key "checkout_products", "checkout_sellers"
  add_foreign_key "checkout_products", "product_prices"
  add_foreign_key "checkout_products", "products"
  add_foreign_key "checkout_sellers", "checkouts"
  add_foreign_key "checkout_sellers", "sellers"
  add_foreign_key "checkouts", "buyers"
  add_foreign_key "checkouts", "payment_methods"
  add_foreign_key "product_add_ons", "add_on_groups"
  add_foreign_key "product_add_ons", "products"
  add_foreign_key "product_categories", "sellers"
  add_foreign_key "product_prices", "product_sizes"
  add_foreign_key "product_prices", "products"
  add_foreign_key "product_sizes", "sellers"
  add_foreign_key "products", "product_categories"
  add_foreign_key "products", "sellers"
  add_foreign_key "sellers", "categories"
end
