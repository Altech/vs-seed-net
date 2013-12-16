# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20131216131859) do

  create_table "comments", force: true do |t|
    t.integer  "video_id",   null: false
    t.float    "time",       null: false
    t.string   "text",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "event_participants", force: true do |t|
    t.integer  "event_id"
    t.integer  "player_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "event_participants", ["event_id"], name: "index_event_participants_on_event_id", using: :btree
  add_index "event_participants", ["player_id"], name: "index_event_participants_on_player_id", using: :btree

  create_table "event_reports", force: true do |t|
    t.integer  "event_id"
    t.text     "body"
    t.integer  "author_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "event_reports", ["author_id"], name: "index_event_reports_on_author_id", using: :btree
  add_index "event_reports", ["event_id"], name: "index_event_reports_on_event_id", using: :btree

  create_table "events", force: true do |t|
    t.datetime "held_at",             null: false
    t.string   "youtube_playlist_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "game_center_id"
  end

  add_index "events", ["youtube_playlist_id"], name: "index_events_on_youtube_playlist_id", unique: true, using: :btree

  create_table "favorites", force: true do |t|
    t.integer  "video_id"
    t.integer  "player_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "game_centers", force: true do |t|
    t.string "station",  null: false
    t.string "name",     null: false
    t.string "location", null: false
  end

  add_index "game_centers", ["location"], name: "index_game_centers_on_location", unique: true, using: :btree

  create_table "mecha_names", force: true do |t|
    t.string   "name",       null: false
    t.integer  "mecha_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "mecha_names", ["mecha_id"], name: "index_mecha_names_on_mecha_id", using: :btree
  add_index "mecha_names", ["name"], name: "index_mecha_names_on_name", unique: true, using: :btree

  create_table "mechas", force: true do |t|
    t.integer  "full_name_id", null: false
    t.integer  "nickname_id",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "cost"
  end

  add_index "mechas", ["full_name_id"], name: "index_mechas_on_full_name_id", using: :btree
  add_index "mechas", ["nickname_id"], name: "index_mechas_on_nickname_id", using: :btree

  create_table "players", force: true do |t|
    t.string   "name",            null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "mail"
    t.string   "password_digest"
  end

  add_index "players", ["name"], name: "index_players_on_name", unique: true, using: :btree

  create_table "sessions", force: true do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "videos", force: true do |t|
    t.string   "youtube_video_id",       null: false
    t.integer  "event_id"
    t.boolean  "win_or_lose"
    t.integer  "mecha_viewpoint_id"
    t.integer  "mecha_consort_id"
    t.integer  "mecha_enemy1_id"
    t.integer  "mecha_enemy2_id"
    t.integer  "player_viewpoint_id"
    t.integer  "player_consort_id"
    t.integer  "player_enemy1_id"
    t.integer  "player_enemy2_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "thumbnail_file_name"
    t.string   "thumbnail_content_type"
    t.integer  "thumbnail_file_size"
    t.datetime "thumbnail_updated_at"
    t.integer  "index_of_event"
  end

  add_index "videos", ["event_id"], name: "index_videos_on_event_id", using: :btree
  add_index "videos", ["mecha_consort_id"], name: "index_videos_on_mecha_consort_id", using: :btree
  add_index "videos", ["mecha_enemy1_id"], name: "index_videos_on_mecha_enemy1_id", using: :btree
  add_index "videos", ["mecha_enemy2_id"], name: "index_videos_on_mecha_enemy2_id", using: :btree
  add_index "videos", ["mecha_viewpoint_id"], name: "index_videos_on_mecha_viewpoint_id", using: :btree
  add_index "videos", ["player_consort_id"], name: "index_videos_on_player_consort_id", using: :btree
  add_index "videos", ["player_enemy1_id"], name: "index_videos_on_player_enemy1_id", using: :btree
  add_index "videos", ["player_enemy2_id"], name: "index_videos_on_player_enemy2_id", using: :btree
  add_index "videos", ["player_viewpoint_id"], name: "index_videos_on_player_viewpoint_id", using: :btree
  add_index "videos", ["youtube_video_id"], name: "index_videos_on_youtube_video_id", unique: true, using: :btree

end
