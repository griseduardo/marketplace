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

ActiveRecord::Schema.define(version: 2020_09_09_122527) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
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

  create_table "answers", force: :cascade do |t|
    t.integer "question_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "answer_message"
    t.index ["question_id"], name: "index_answers_on_question_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "cnpj"
    t.string "domain"
    t.string "website"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "departments", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "negotiations", force: :cascade do |t|
    t.text "negotiation_message"
    t.integer "profile_id", null: false
    t.integer "purchased_product_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["profile_id"], name: "index_negotiations_on_profile_id"
    t.index ["purchased_product_id"], name: "index_negotiations_on_purchased_product_id"
  end

  create_table "product_categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "product_conditions", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "product_subcategories", force: :cascade do |t|
    t.string "name"
    t.integer "product_category_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_category_id"], name: "index_product_subcategories_on_product_category_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.integer "product_subcategory_id", null: false
    t.text "description"
    t.float "price"
    t.integer "product_condition_id", null: false
    t.integer "quantity"
    t.integer "profile_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status"
    t.index ["product_condition_id"], name: "index_products_on_product_condition_id"
    t.index ["product_subcategory_id"], name: "index_products_on_product_subcategory_id"
    t.index ["profile_id"], name: "index_products_on_profile_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "full_name"
    t.string "chosen_name"
    t.date "birthday"
    t.string "position"
    t.string "sector"
    t.integer "department_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "work_address"
    t.index ["department_id"], name: "index_profiles_on_department_id"
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "purchased_products", force: :cascade do |t|
    t.integer "product_id", null: false
    t.integer "profile_id", null: false
    t.integer "total_quantity"
    t.date "start_date"
    t.date "end_date"
    t.float "final_value"
    t.integer "status", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "initial_value"
    t.float "freight_cost"
    t.float "discount"
    t.index ["product_id"], name: "index_purchased_products_on_product_id"
    t.index ["profile_id"], name: "index_purchased_products_on_profile_id"
  end

  create_table "questions", force: :cascade do |t|
    t.integer "product_id", null: false
    t.integer "profile_id", null: false
    t.text "question_message"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id"], name: "index_questions_on_product_id"
    t.index ["profile_id"], name: "index_questions_on_profile_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "company_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_users_on_company_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "answers", "questions"
  add_foreign_key "negotiations", "profiles"
  add_foreign_key "negotiations", "purchased_products"
  add_foreign_key "product_subcategories", "product_categories"
  add_foreign_key "products", "product_conditions"
  add_foreign_key "products", "product_subcategories"
  add_foreign_key "products", "profiles"
  add_foreign_key "profiles", "departments"
  add_foreign_key "profiles", "users"
  add_foreign_key "purchased_products", "products"
  add_foreign_key "purchased_products", "profiles"
  add_foreign_key "questions", "products"
  add_foreign_key "questions", "profiles"
end
