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

ActiveRecord::Schema.define(version: 2021_02_08_024610) do

  create_table "casts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "character_id", null: false
    t.string "work_title"
    t.string "name"
    t.string "name_kana"
    t.string "gender"
    t.string "blood_type"
    t.string "birthday"
    t.string "url"
    t.string "wikipedia_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["character_id"], name: "index_casts_on_character_id"
  end

  create_table "characters", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "work_id"
    t.string "name"
    t.string "nick_name"
    t.string "birthday"
    t.string "age"
    t.string "blood_type"
    t.text "description"
    t.string "description_source"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["work_id"], name: "index_characters_on_work_id"
  end

  create_table "danimes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "tag_id", null: false
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["tag_id"], name: "index_danimes_on_tag_id"
  end

  create_table "organizations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name"
    t.string "name_kana"
    t.string "name_en"
    t.text "url"
    t.text "wikipedia_url"
    t.string "twitter_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "seasons", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "series", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "staffs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "work_id", null: false
    t.text "name"
    t.string "role_text"
    t.string "role_other"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["work_id"], name: "index_staffs_on_work_id"
  end

  create_table "tags", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_profiles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "nick_name", default: "ゲストユーザー"
    t.string "image", default: ""
    t.text "string"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_user_profiles_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name", default: "ゲストユーザー"
    t.string "email", null: false
    t.string "password_digest"
    t.boolean "admin", default: false
    t.boolean "display_mode", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "workcasts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "work_id", null: false
    t.bigint "cast_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["cast_id"], name: "index_workcasts_on_cast_id"
    t.index ["work_id"], name: "index_workcasts_on_work_id"
  end

  create_table "works", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "season_id", null: false
    t.string "season_name"
    t.string "season_name_text"
    t.integer "season_year", null: false
    t.string "title", null: false
    t.integer "episodes_count", default: 0, null: false
    t.string "facebook_og_image_url", default: "", null: false
    t.date "released_at"
    t.string "media", null: false
    t.string "media_text", null: false
    t.string "official_site_url", default: "", null: false
    t.string "twitter_hashtag"
    t.string "twitter_image_url", default: "", null: false
    t.string "twitter_username"
    t.string "recommended_image_url", default: "", null: false
    t.string "wikipedia_url", limit: 500
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["season_id"], name: "index_works_on_season_id"
  end

  create_table "worktags", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "work_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["tag_id"], name: "index_worktags_on_tag_id"
    t.index ["work_id", "tag_id"], name: "index_worktags_on_work_id_and_tag_id", unique: true
    t.index ["work_id"], name: "index_worktags_on_work_id"
  end

  add_foreign_key "casts", "characters"
  add_foreign_key "characters", "works"
  add_foreign_key "characters", "works", name: "characters_ibfk_3", on_delete: :cascade
  add_foreign_key "characters", "works", name: "characters_ibfk_4", on_delete: :cascade
  add_foreign_key "characters", "works", name: "characters_ibfk_5", on_delete: :cascade
  add_foreign_key "characters", "works", name: "characters_ibfk_6", on_delete: :cascade
  add_foreign_key "danimes", "tags"
  add_foreign_key "staffs", "works"
  add_foreign_key "user_profiles", "users"
  add_foreign_key "workcasts", "casts"
  add_foreign_key "workcasts", "works"
  add_foreign_key "worktags", "tags"
  add_foreign_key "worktags", "works"
end
