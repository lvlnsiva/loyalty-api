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

ActiveRecord::Schema[7.2].define(version: 2025_05_10_111214) do
  create_table "customer_transactions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.decimal "amount"
    t.string "currency"
    t.string "country"
    t.datetime "transaction_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_customer_transactions_on_user_id"
  end

  create_table "points", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "customer_transaction_id", null: false
    t.integer "points"
    t.string "reason"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_transaction_id"], name: "index_points_on_customer_transaction_id"
    t.index ["user_id"], name: "index_points_on_user_id"
  end

  create_table "rewards", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "reward_type"
    t.datetime "issued_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_rewards_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.integer "level"
    t.date "date_of_birth"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "api_key"
    t.index ["api_key"], name: "index_users_on_api_key", unique: true
  end

  add_foreign_key "customer_transactions", "users"
  add_foreign_key "points", "customer_transactions"
  add_foreign_key "points", "users"
  add_foreign_key "rewards", "users"
end
