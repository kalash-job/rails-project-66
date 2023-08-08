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

ActiveRecord::Schema[7.0].define(version: 2023_08_08_212121) do
  create_table "repositories", force: :cascade do |t|
    t.string "name"
    t.string "full_name"
    t.string "language"
    t.integer "github_id"
    t.string "clone_url"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["github_id"], name: "index_repositories_on_github_id", unique: true
    t.index ["user_id"], name: "index_repositories_on_user_id"
  end

  create_table "repository_checks", force: :cascade do |t|
    t.string "commit_id"
    t.integer "offenses_count"
    t.boolean "passed", default: false
    t.integer "repository_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "aasm_state"
    t.index ["repository_id"], name: "index_repository_checks_on_repository_id"
  end

  create_table "repository_offenses", force: :cascade do |t|
    t.string "path"
    t.string "rule_id"
    t.string "message"
    t.string "coords"
    t.integer "check_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["check_id"], name: "index_repository_offenses_on_check_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "nickname"
    t.string "email"
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "repositories", "users"
  add_foreign_key "repository_checks", "repositories"
  add_foreign_key "repository_offenses", "repository_checks", column: "check_id"
end
