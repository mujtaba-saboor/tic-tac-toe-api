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

ActiveRecord::Schema.define(version: 2023_06_08_124908) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "game_boards", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "completed"
  end

  create_table "turns", force: :cascade do |t|
    t.bigint "game_board_id"
    t.integer "tile_type"
    t.integer "tile_position"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["game_board_id"], name: "index_turns_on_game_board_id"
  end

  create_table "winners", force: :cascade do |t|
    t.bigint "game_board_id"
    t.string "won_by"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["game_board_id"], name: "index_winners_on_game_board_id"
  end

  add_foreign_key "turns", "game_boards"
  add_foreign_key "winners", "game_boards"
end
