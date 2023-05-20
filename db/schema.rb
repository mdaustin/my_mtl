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

ActiveRecord::Schema[7.0].define(version: 2023_05_20_201500) do
  create_table "movies", force: :cascade do |t|
    t.integer "tmdb_id"
    t.string "title"
    t.text "overview"
    t.date "release_date"
    t.integer "runtime"
    t.string "poster_path"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tmdb_id"], name: "index_movies_on_tmdb_id", unique: true
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
  end

  create_table "tier_lists", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_tier_lists_on_user_id"
  end

  create_table "tier_movies", force: :cascade do |t|
    t.integer "tier_id", null: false
    t.integer "movie_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "row_order"
    t.index ["movie_id"], name: "index_tier_movies_on_movie_id"
    t.index ["tier_id", "movie_id"], name: "index_tier_movies_on_tier_id_and_movie_id", unique: true
    t.index ["tier_id"], name: "index_tier_movies_on_tier_id"
  end

  create_table "tiers", force: :cascade do |t|
    t.integer "tier_list_id", null: false
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "row_order"
    t.index ["tier_list_id"], name: "index_tiers_on_tier_list_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "remember_digest"
    t.boolean "admin", default: false
    t.string "activation_digest"
    t.boolean "activated", default: false
    t.datetime "activated_at"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "tier_lists", "users"
  add_foreign_key "tier_movies", "movies"
  add_foreign_key "tier_movies", "tiers"
  add_foreign_key "tiers", "tier_lists"
end
