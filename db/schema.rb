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

ActiveRecord::Schema.define(version: 2021_12_13_104902) do

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
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "title"
    t.bigint "seller_id", null: false
    t.index ["seller_id"], name: "index_add_on_groups_on_seller_id"
  end

  create_table "add_on_to_groups", force: :cascade do |t|
    t.bigint "add_on_group_id", null: false
    t.bigint "add_on_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["add_on_group_id"], name: "index_add_on_to_groups_on_add_on_group_id"
    t.index ["add_on_id"], name: "index_add_on_to_groups_on_add_on_id"
  end

  create_table "add_ons", force: :cascade do |t|
    t.float "price"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "seller_id", null: false
    t.index ["seller_id"], name: "index_add_ons_on_seller_id"
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

  create_table "buyer_vouchers", force: :cascade do |t|
    t.bigint "buyer_id", null: false
    t.bigint "voucher_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["buyer_id"], name: "index_buyer_vouchers_on_buyer_id"
    t.index ["voucher_id"], name: "index_buyer_vouchers_on_voucher_id"
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
    t.bigint "add_on_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "cart_product_id", null: false
    t.index ["add_on_id"], name: "index_cart_add_ons_on_add_on_id"
    t.index ["cart_product_id"], name: "index_cart_add_ons_on_cart_product_id"
  end

  create_table "cart_products", force: :cascade do |t|
    t.bigint "cart_seller_id", null: false
    t.bigint "product_id", null: false
    t.bigint "product_size_id", null: false
    t.integer "quantity"
    t.float "one_qty_price"
    t.float "total"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["cart_seller_id"], name: "index_cart_products_on_cart_seller_id"
    t.index ["product_id"], name: "index_cart_products_on_product_id"
    t.index ["product_size_id"], name: "index_cart_products_on_product_size_id"
  end

  create_table "cart_sellers", force: :cascade do |t|
    t.bigint "buyer_id", null: false
    t.bigint "seller_id", null: false
    t.float "sub_total"
    t.float "delivery_fee"
    t.bigint "voucher_id", null: false
    t.float "vat"
    t.float "total"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["buyer_id"], name: "index_cart_sellers_on_buyer_id"
    t.index ["seller_id"], name: "index_cart_sellers_on_seller_id"
    t.index ["voucher_id"], name: "index_cart_sellers_on_voucher_id"
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
    t.string "size"
    t.float "price"
    t.integer "quantity"
    t.float "total"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "description"
    t.string "name"
    t.index ["checkout_seller_id"], name: "index_checkout_products_on_checkout_seller_id"
    t.index ["product_id"], name: "index_checkout_products_on_product_id"
  end

  create_table "checkout_sellers", force: :cascade do |t|
    t.bigint "checkout_id", null: false
    t.bigint "seller_id", null: false
    t.float "delivery_fee"
    t.float "total"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status", default: 0
    t.bigint "voucher_id"
    t.float "subtotal", default: 0.0
    t.float "vat"
    t.bigint "rider_id"
    t.datetime "enqueued_time"
    t.index ["checkout_id"], name: "index_checkout_sellers_on_checkout_id"
    t.index ["rider_id"], name: "index_checkout_sellers_on_rider_id"
    t.index ["seller_id"], name: "index_checkout_sellers_on_seller_id"
    t.index ["voucher_id"], name: "index_checkout_sellers_on_voucher_id"
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

  create_table "discount_trackers", force: :cascade do |t|
    t.bigint "seller_id", null: false
    t.integer "discount_type"
    t.float "discount_amount"
    t.string "products_id"
    t.float "min_amount"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["seller_id"], name: "index_discount_trackers_on_seller_id"
  end

  create_table "locations", force: :cascade do |t|
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
    t.bigint "buyer_id", null: false
    t.index ["buyer_id"], name: "index_locations_on_buyer_id"
  end

  create_table "payment_methods", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "pg_search_documents", force: :cascade do |t|
    t.text "content"
    t.string "searchable_type"
    t.bigint "searchable_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["searchable_type", "searchable_id"], name: "index_pg_search_documents_on_searchable_type_and_searchable_id"
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

  create_table "product_sizes", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "product_id"
    t.float "price"
    t.index ["product_id"], name: "index_product_sizes_on_product_id"
  end

  create_table "product_template_aogs", force: :cascade do |t|
    t.string "name"
    t.bigint "seller_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["seller_id"], name: "index_product_template_aogs_on_seller_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.bigint "product_category_id", null: false
    t.bigint "seller_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "description"
    t.bigint "product_template_aog_id"
    t.index ["product_category_id"], name: "index_products_on_product_category_id"
    t.index ["product_template_aog_id"], name: "index_products_on_product_template_aog_id"
    t.index ["seller_id"], name: "index_products_on_seller_id"
  end

  create_table "record_trackers", force: :cascade do |t|
    t.bigint "seller_id", null: false
    t.string "object_type", null: false
    t.bigint "object_id", null: false
    t.string "attribute"
    t.string "old_data"
    t.string "new_Data"
    t.integer "status"
    t.datetime "approved_date"
    t.datetime "declined_date"
    t.string "declined_reason"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["object_type", "object_id"], name: "index_record_trackers_on_object_type_and_object_id"
    t.index ["seller_id"], name: "index_record_trackers_on_seller_id"
  end

  create_table "rider_transactions", force: :cascade do |t|
    t.bigint "rider_id", null: false
    t.bigint "checkout_seller_id", null: false
    t.integer "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["checkout_seller_id"], name: "index_rider_transactions_on_checkout_seller_id"
    t.index ["rider_id"], name: "index_rider_transactions_on_rider_id"
  end

  create_table "riders", force: :cascade do |t|
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
    t.string "image"
    t.string "email"
    t.json "tokens"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "phone_number"
    t.string "first_name"
    t.string "last_name"
    t.integer "status", default: 0
    t.float "acceptance_rate", default: 0.0
    t.float "longitude"
    t.float "latitude"
    t.index ["confirmation_token"], name: "index_riders_on_confirmation_token", unique: true
    t.index ["email"], name: "index_riders_on_email", unique: true
    t.index ["reset_password_token"], name: "index_riders_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_riders_on_uid_and_provider", unique: true
  end

  create_table "schedules", force: :cascade do |t|
    t.bigint "seller_id", null: false
    t.string "monday_start"
    t.string "monday_end"
    t.string "tuesday_start"
    t.string "tuesday_end"
    t.string "wednesday_start"
    t.string "wednesday_end"
    t.string "thursday_start"
    t.string "thursday_end"
    t.string "friday_start"
    t.string "friday_end"
    t.string "saturday_start"
    t.string "saturday_end"
    t.string "sunday_start"
    t.string "sunday_end"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["seller_id"], name: "index_schedules_on_seller_id"
  end

  create_table "seller_transactions", force: :cascade do |t|
    t.bigint "seller_id", null: false
    t.bigint "checkout_seller_id", null: false
    t.float "sub_total"
    t.float "fees_amount"
    t.float "total"
    t.boolean "is_paid"
    t.string "payment_method"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["checkout_seller_id"], name: "index_seller_transactions_on_checkout_seller_id"
    t.index ["seller_id"], name: "index_seller_transactions_on_seller_id"
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
    t.string "email"
    t.json "tokens"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "phone_number"
    t.bigint "category_id", null: false
    t.boolean "is_open", default: false
    t.float "longitude"
    t.float "latitude"
    t.string "details"
    t.string "street"
    t.string "village"
    t.string "city"
    t.string "state"
    t.index ["category_id"], name: "index_sellers_on_category_id"
    t.index ["confirmation_token"], name: "index_sellers_on_confirmation_token", unique: true
    t.index ["email"], name: "index_sellers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_sellers_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_sellers_on_uid_and_provider", unique: true
  end

  create_table "template_aogs", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "product_template_aog_id", null: false
    t.bigint "add_on_group_id", null: false
    t.boolean "is_required"
    t.integer "num_of_choices"
    t.index ["add_on_group_id"], name: "index_template_aogs_on_add_on_group_id"
    t.index ["product_template_aog_id"], name: "index_template_aogs_on_product_template_aog_id"
  end

  create_table "vouchers", force: :cascade do |t|
    t.string "code"
    t.string "description"
    t.float "discount"
    t.string "discount_type"
    t.float "min_amount"
    t.float "max_discount"
    t.datetime "valid_from"
    t.datetime "valid_until"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status"
  end

  create_table "wallets", force: :cascade do |t|
    t.string "user_type", null: false
    t.bigint "user_id", null: false
    t.float "amount"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_type", "user_id"], name: "index_wallets_on_user_type_and_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "add_on_groups", "sellers"
  add_foreign_key "add_on_to_groups", "add_on_groups"
  add_foreign_key "add_on_to_groups", "add_ons"
  add_foreign_key "add_ons", "sellers"
  add_foreign_key "buyer_payment_methods", "buyers"
  add_foreign_key "buyer_payment_methods", "payment_methods"
  add_foreign_key "buyer_vouchers", "buyers"
  add_foreign_key "buyer_vouchers", "vouchers"
  add_foreign_key "cart_add_ons", "add_ons"
  add_foreign_key "cart_add_ons", "cart_products"
  add_foreign_key "cart_products", "cart_sellers"
  add_foreign_key "cart_products", "product_sizes"
  add_foreign_key "cart_products", "products"
  add_foreign_key "cart_sellers", "buyers"
  add_foreign_key "cart_sellers", "sellers"
  add_foreign_key "cart_sellers", "vouchers"
  add_foreign_key "category_deals", "categories"
  add_foreign_key "checkout_add_ons", "add_ons"
  add_foreign_key "checkout_add_ons", "checkout_products"
  add_foreign_key "checkout_products", "checkout_sellers"
  add_foreign_key "checkout_products", "products"
  add_foreign_key "checkout_sellers", "checkouts"
  add_foreign_key "checkout_sellers", "riders"
  add_foreign_key "checkout_sellers", "sellers"
  add_foreign_key "checkout_sellers", "vouchers"
  add_foreign_key "checkouts", "buyers"
  add_foreign_key "checkouts", "payment_methods"
  add_foreign_key "discount_trackers", "sellers"
  add_foreign_key "locations", "buyers"
  add_foreign_key "product_add_ons", "add_on_groups"
  add_foreign_key "product_add_ons", "products"
  add_foreign_key "product_categories", "sellers"
  add_foreign_key "product_sizes", "products"
  add_foreign_key "product_template_aogs", "sellers"
  add_foreign_key "products", "product_categories"
  add_foreign_key "products", "product_template_aogs"
  add_foreign_key "products", "sellers"
  add_foreign_key "record_trackers", "sellers"
  add_foreign_key "rider_transactions", "checkout_sellers"
  add_foreign_key "rider_transactions", "riders"
  add_foreign_key "schedules", "sellers"
  add_foreign_key "seller_transactions", "checkout_sellers"
  add_foreign_key "seller_transactions", "sellers"
  add_foreign_key "sellers", "categories"
  add_foreign_key "template_aogs", "add_on_groups"
  add_foreign_key "template_aogs", "product_template_aogs"
end
