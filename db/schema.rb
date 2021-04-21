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

ActiveRecord::Schema.define(version: 2021_04_21_033216) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "characters", force: :cascade do |t|
    t.string "name"
    t.string "image_data"
    t.integer "age"
    t.integer "weight_kg"
    t.string "history"
    t.bigint "studio_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["studio_id"], name: "index_characters_on_studio_id"
  end

  create_table "characters_movies", id: false, force: :cascade do |t|
    t.bigint "character_id", null: false
    t.bigint "movie_id", null: false
    t.index ["character_id", "movie_id"], name: "index_characters_movies_on_character_id_and_movie_id"
    t.index ["movie_id", "character_id"], name: "index_characters_movies_on_movie_id_and_character_id"
  end

  create_table "characters_seriees", id: false, force: :cascade do |t|
    t.bigint "character_id", null: false
    t.bigint "seriee_id", null: false
    t.index ["character_id", "seriee_id"], name: "index_characters_seriees_on_character_id_and_seriee_id"
    t.index ["seriee_id", "character_id"], name: "index_characters_seriees_on_seriee_id_and_character_id"
  end

  create_table "genres", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "genres_movies", id: false, force: :cascade do |t|
    t.bigint "genre_id", null: false
    t.bigint "movie_id", null: false
    t.index ["genre_id", "movie_id"], name: "index_genres_movies_on_genre_id_and_movie_id"
    t.index ["movie_id", "genre_id"], name: "index_genres_movies_on_movie_id_and_genre_id"
  end

  create_table "genres_seriees", id: false, force: :cascade do |t|
    t.bigint "genre_id", null: false
    t.bigint "seriee_id", null: false
    t.index ["genre_id", "seriee_id"], name: "index_genres_seriees_on_genre_id_and_seriee_id"
    t.index ["seriee_id", "genre_id"], name: "index_genres_seriees_on_seriee_id_and_genre_id"
  end

  create_table "movies", force: :cascade do |t|
    t.string "title"
    t.string "image_data"
    t.date "date_released"
    t.integer "score"
    t.bigint "studio_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["studio_id"], name: "index_movies_on_studio_id"
  end

  create_table "seriees", force: :cascade do |t|
    t.string "title"
    t.string "image_data"
    t.date "date_released"
    t.integer "seasons"
    t.integer "score"
    t.bigint "studio_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["studio_id"], name: "index_seriees_on_studio_id"
  end

  create_table "studios", force: :cascade do |t|
    t.string "name"
    t.string "image_data"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "characters", "studios"
  add_foreign_key "movies", "studios"
  add_foreign_key "seriees", "studios"
end
