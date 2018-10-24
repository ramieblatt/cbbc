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

ActiveRecord::Schema.define(version: 20181024233639) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "all_star_appearances", force: :cascade do |t|
    t.integer "player_id", null: false
    t.integer "year_id", null: false
    t.string "game_number", null: false
    t.string "game_code"
    t.string "team_code", null: false
    t.string "league_code", null: false
    t.boolean "played", default: false, null: false
    t.integer "starting_pos"
    t.string "lahman_player_id", null: false
    t.index ["game_code"], name: "index_all_star_appearances_on_game_code"
    t.index ["game_number"], name: "index_all_star_appearances_on_game_number"
    t.index ["lahman_player_id"], name: "index_all_star_appearances_on_lahman_player_id"
    t.index ["league_code"], name: "index_all_star_appearances_on_league_code"
    t.index ["team_code"], name: "index_all_star_appearances_on_team_code"
    t.index ["year_id"], name: "index_all_star_appearances_on_year_id"
  end

  create_table "appearances", force: :cascade do |t|
    t.integer "player_id", null: false
    t.integer "year_id", null: false
    t.string "team_code", null: false
    t.string "league_code", null: false
    t.integer "num_g"
    t.integer "num_gs"
    t.integer "num_gb"
    t.integer "num_gd"
    t.integer "num_gp"
    t.integer "num_gc"
    t.integer "num_g1b"
    t.integer "num_g2b"
    t.integer "num_g3b"
    t.integer "num_gss"
    t.integer "num_glf"
    t.integer "num_gcf"
    t.integer "num_grf"
    t.integer "num_gof"
    t.integer "num_gdh"
    t.integer "num_gph"
    t.integer "num_gpr"
    t.string "lahman_player_id", null: false
    t.index ["lahman_player_id"], name: "index_appearances_on_lahman_player_id"
    t.index ["league_code"], name: "index_appearances_on_league_code"
    t.index ["team_code"], name: "index_appearances_on_team_code"
    t.index ["year_id"], name: "index_appearances_on_year_id"
  end

  create_table "authentications", force: :cascade do |t|
    t.integer "account_id", null: false
    t.string "provider", null: false
    t.string "uid", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_authentications_on_account_id"
    t.index ["provider"], name: "index_authentications_on_provider"
    t.index ["uid"], name: "index_authentications_on_uid"
  end

  create_table "batting_stats", force: :cascade do |t|
    t.integer "player_id", null: false
    t.integer "year_id", null: false
    t.integer "stint", null: false
    t.string "team_code", null: false
    t.string "league_code", null: false
    t.integer "num_g"
    t.integer "num_ab"
    t.integer "num_r"
    t.integer "num_h"
    t.integer "num_2b"
    t.integer "num_3b"
    t.integer "num_hr"
    t.integer "num_rbi"
    t.integer "num_sb"
    t.integer "num_cs"
    t.integer "num_bb"
    t.integer "num_so"
    t.integer "num_ibb"
    t.integer "num_hbp"
    t.integer "num_sh"
    t.integer "num_sf"
    t.integer "num_gidp"
    t.string "lahman_player_id", null: false
    t.index ["lahman_player_id"], name: "index_batting_stats_on_lahman_player_id"
    t.index ["league_code"], name: "index_batting_stats_on_league_code"
    t.index ["stint"], name: "index_batting_stats_on_stint"
    t.index ["team_code"], name: "index_batting_stats_on_team_code"
    t.index ["year_id"], name: "index_batting_stats_on_year_id"
  end

  create_table "cards", force: :cascade do |t|
    t.integer "player_id", null: false
    t.integer "edition_id", null: false
    t.date "minted_at"
    t.integer "series_index", default: 1, null: false
    t.integer "total_cards_in_series", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "card_type", default: "player", null: false
    t.integer "token_id"
    t.index ["edition_id"], name: "index_cards_on_edition_id"
    t.index ["minted_at"], name: "index_cards_on_minted_at"
    t.index ["player_id"], name: "index_cards_on_player_id"
    t.index ["series_index"], name: "index_cards_on_series_index"
  end

  create_table "editions", force: :cascade do |t|
    t.string "name", null: false
    t.integer "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_published", default: false, null: false
    t.datetime "published_at"
    t.index ["name"], name: "index_editions_on_name"
    t.index ["number"], name: "index_editions_on_number"
  end

  create_table "fielding_stats", force: :cascade do |t|
    t.integer "player_id", null: false
    t.integer "year_id", null: false
    t.integer "stint", null: false
    t.string "team_code", null: false
    t.string "league_code", null: false
    t.string "position_code", null: false
    t.integer "num_g"
    t.integer "num_gs"
    t.integer "num_innouts"
    t.integer "num_po"
    t.integer "num_a"
    t.integer "num_e"
    t.integer "num_dp"
    t.integer "num_pb"
    t.integer "num_wp"
    t.integer "num_sb"
    t.integer "num_cs"
    t.integer "zr"
    t.string "lahman_player_id", null: false
    t.index ["lahman_player_id"], name: "index_fielding_stats_on_lahman_player_id"
    t.index ["league_code"], name: "index_fielding_stats_on_league_code"
    t.index ["position_code"], name: "index_fielding_stats_on_position_code"
    t.index ["stint"], name: "index_fielding_stats_on_stint"
    t.index ["team_code"], name: "index_fielding_stats_on_team_code"
    t.index ["year_id"], name: "index_fielding_stats_on_year_id"
  end

  create_table "hall_of_fame_appearances", force: :cascade do |t|
    t.integer "player_id", null: false
    t.integer "year_id", null: false
    t.string "voted_by", null: false
    t.integer "ballots"
    t.integer "needed"
    t.integer "votes"
    t.boolean "inducted", default: false, null: false
    t.string "category", null: false
    t.string "needed_note"
    t.string "lahman_player_id", null: false
    t.index ["category"], name: "index_hall_of_fame_appearances_on_category"
    t.index ["lahman_player_id"], name: "index_hall_of_fame_appearances_on_lahman_player_id"
    t.index ["voted_by"], name: "index_hall_of_fame_appearances_on_voted_by"
    t.index ["year_id"], name: "index_hall_of_fame_appearances_on_year_id"
  end

  create_table "legacy_all_star_full", primary_key: ["playerID", "yearID", "gameNum"], force: :cascade do |t|
    t.string "playerID", limit: 18, null: false
    t.integer "yearID", null: false
    t.integer "gameNum", null: false
    t.string "gameID", limit: 24
    t.string "teamID", limit: 6
    t.string "lgID", limit: 4
    t.integer "GP"
    t.integer "startingPos"
    t.index ["gameID"], name: "AllstarFull_gameID_idx"
    t.index ["lgID"], name: "AllstarFull_lgID_idx"
    t.index ["teamID"], name: "AllstarFull_teamID_idx"
  end

  create_table "legacy_appearances", primary_key: ["yearID", "teamID", "playerID"], force: :cascade do |t|
    t.integer "yearID", null: false
    t.string "teamID", limit: 6, null: false
    t.string "lgID", limit: 4
    t.string "playerID", limit: 18, null: false
    t.integer "G_all"
    t.integer "GS"
    t.integer "G_batting"
    t.integer "G_defense"
    t.integer "G_p"
    t.integer "G_c"
    t.integer "G_1b"
    t.integer "G_2b"
    t.integer "G_3b"
    t.integer "G_ss"
    t.integer "G_lf"
    t.integer "G_cf"
    t.integer "G_rf"
    t.integer "G_of"
    t.integer "G_dh"
    t.integer "G_ph"
    t.integer "G_pr"
    t.index ["lgID"], name: "Appearances_lgID_idx"
  end

  create_table "legacy_awards_managers", primary_key: ["yearID", "awardID", "lgID", "playerID"], force: :cascade do |t|
    t.string "playerID", limit: 20, null: false
    t.string "awardID", limit: 150, null: false
    t.integer "yearID", null: false
    t.string "lgID", limit: 4, null: false
    t.string "tie", limit: 2
    t.string "notes", limit: 200
  end

  create_table "legacy_awards_players", primary_key: ["yearID", "awardID", "lgID", "playerID"], force: :cascade do |t|
    t.string "playerID", limit: 18, null: false
    t.string "awardID", limit: 510, null: false
    t.integer "yearID", null: false
    t.string "lgID", limit: 4, null: false
    t.string "tie", limit: 2
    t.string "notes", limit: 200
  end

  create_table "legacy_awards_share_managers", primary_key: ["awardID", "yearID", "lgID", "playerID"], force: :cascade do |t|
    t.string "awardID", limit: 50, null: false
    t.integer "yearID", null: false
    t.string "lgID", limit: 4, null: false
    t.string "playerID", limit: 20, null: false
    t.integer "pointsWon"
    t.integer "pointsMax"
    t.integer "votesFirst"
  end

  create_table "legacy_awards_share_players", primary_key: ["awardID", "yearID", "lgID", "playerID"], force: :cascade do |t|
    t.string "awardID", limit: 50, null: false
    t.integer "yearID", null: false
    t.string "lgID", limit: 4, null: false
    t.string "playerID", limit: 18, null: false
    t.float "pointsWon"
    t.integer "pointsMax"
    t.float "votesFirst"
  end

  create_table "legacy_batting", primary_key: ["playerID", "yearID", "stint"], force: :cascade do |t|
    t.string "playerID", limit: 18, null: false
    t.integer "yearID", null: false
    t.integer "stint", null: false
    t.string "teamID", limit: 6
    t.string "lgID", limit: 4
    t.integer "G"
    t.integer "G_batting"
    t.integer "AB"
    t.integer "R"
    t.integer "H"
    t.integer "2B"
    t.integer "3B"
    t.integer "HR"
    t.integer "RBI"
    t.integer "SB"
    t.integer "CS"
    t.integer "BB"
    t.integer "SO"
    t.integer "IBB"
    t.integer "HBP"
    t.integer "SH"
    t.integer "SF"
    t.integer "GIDP"
    t.integer "G_old"
    t.index ["lgID"], name: "Batting_lgID_idx"
    t.index ["teamID"], name: "Batting_teamID_idx"
  end

  create_table "legacy_batting_post", primary_key: ["yearID", "round", "playerID"], force: :cascade do |t|
    t.integer "yearID", null: false
    t.string "round", limit: 20, null: false
    t.string "playerID", limit: 18, null: false
    t.string "teamID", limit: 6
    t.string "lgID", limit: 4
    t.integer "G"
    t.integer "AB"
    t.integer "R"
    t.integer "H"
    t.integer "2B"
    t.integer "3B"
    t.integer "HR"
    t.integer "RBI"
    t.integer "SB"
    t.integer "CS"
    t.integer "BB"
    t.integer "SO"
    t.integer "IBB"
    t.integer "HBP"
    t.integer "SH"
    t.integer "SF"
    t.integer "GIDP"
    t.index ["lgID"], name: "BattingPost_lgID_idx"
    t.index ["teamID"], name: "BattingPost_teamID_idx"
  end

  create_table "legacy_college_playing", id: false, force: :cascade do |t|
    t.string "playerID", limit: 18, null: false
    t.string "schoolID", limit: 30
    t.integer "yearID"
  end

  create_table "legacy_fielding", primary_key: ["playerID", "yearID", "stint", "POS"], force: :cascade do |t|
    t.string "playerID", limit: 18, null: false
    t.integer "yearID", null: false
    t.integer "stint", null: false
    t.string "teamID", limit: 6
    t.string "lgID", limit: 4
    t.string "POS", limit: 4, null: false
    t.integer "G"
    t.integer "GS"
    t.integer "InnOuts"
    t.integer "PO"
    t.integer "A"
    t.integer "E"
    t.integer "DP"
    t.integer "PB"
    t.integer "WP"
    t.integer "SB"
    t.integer "CS"
    t.float "ZR"
    t.index ["lgID"], name: "Fielding_lgID_idx"
    t.index ["teamID"], name: "Fielding_teamID_idx"
  end

  create_table "legacy_fielding_of", primary_key: ["playerID", "yearID", "stint"], force: :cascade do |t|
    t.string "playerID", limit: 18, null: false
    t.integer "yearID", null: false
    t.integer "stint", null: false
    t.integer "Glf"
    t.integer "Gcf"
    t.integer "Grf"
  end

  create_table "legacy_fielding_of_split", primary_key: ["playerID", "yearID", "stint", "POS"], force: :cascade do |t|
    t.string "playerID", limit: 18, null: false
    t.integer "yearID", null: false
    t.integer "stint", null: false
    t.string "teamID", limit: 6
    t.string "lgID", limit: 4
    t.string "POS", limit: 4, null: false
    t.integer "G"
    t.integer "GS"
    t.integer "InnOuts"
    t.integer "PO"
    t.integer "A"
    t.integer "E"
    t.integer "DP"
    t.integer "PB"
    t.integer "WP"
    t.integer "SB"
    t.integer "CS"
    t.float "ZR"
    t.index ["lgID"], name: "FieldingOFsplit_lgID_idx"
    t.index ["teamID"], name: "FieldingOFsplit_teamID_idx"
  end

  create_table "legacy_fielding_post", primary_key: ["playerID", "yearID", "round", "POS"], force: :cascade do |t|
    t.string "playerID", limit: 18, null: false
    t.integer "yearID", null: false
    t.string "teamID", limit: 6
    t.string "lgID", limit: 4
    t.string "round", limit: 20, null: false
    t.string "POS", limit: 4, null: false
    t.integer "G"
    t.integer "GS"
    t.integer "InnOuts"
    t.integer "PO"
    t.integer "A"
    t.integer "E"
    t.integer "DP"
    t.integer "TP"
    t.integer "PB"
    t.integer "SB"
    t.integer "CS"
    t.index ["lgID"], name: "FieldingPost_lgID_idx"
    t.index ["teamID"], name: "FieldingPost_teamID_idx"
  end

  create_table "legacy_hall_of_fame", primary_key: ["playerID", "yearid", "votedBy"], force: :cascade do |t|
    t.string "playerID", limit: 20, null: false
    t.integer "yearid", null: false
    t.string "votedBy", limit: 128, null: false
    t.integer "ballots"
    t.integer "needed"
    t.integer "votes"
    t.string "inducted", limit: 2
    t.string "category", limit: 40
    t.string "needed_note", limit: 50
  end

  create_table "legacy_home_games", id: false, force: :cascade do |t|
    t.integer "yearkey"
    t.string "leaguekey", limit: 510
    t.string "teamkey", limit: 510
    t.string "parkkey", limit: 510
    t.string "spanfirst", limit: 510
    t.string "spanlast", limit: 510
    t.integer "games"
    t.integer "openings"
    t.integer "attendance"
    t.index ["leaguekey"], name: "HomeGames_leaguekey_idx"
    t.index ["parkkey"], name: "HomeGames_parkkey_idx"
    t.index ["teamkey"], name: "HomeGames_teamkey_idx"
    t.index ["yearkey"], name: "HomeGames_yearkey_idx"
  end

  create_table "legacy_managers", primary_key: ["yearID", "teamID", "inseason"], force: :cascade do |t|
    t.string "playerID", limit: 20
    t.integer "yearID", null: false
    t.string "teamID", limit: 6, null: false
    t.string "lgID", limit: 4
    t.integer "inseason", null: false
    t.integer "G"
    t.integer "W"
    t.integer "L"
    t.integer "rank"
    t.string "plyrMgr", limit: 2
    t.index ["lgID"], name: "Managers_lgID_idx"
    t.index ["playerID"], name: "Managers_managerID_idx"
  end

  create_table "legacy_managers_half", primary_key: ["yearID", "teamID", "playerID", "half"], force: :cascade do |t|
    t.string "playerID", limit: 20, null: false
    t.integer "yearID", null: false
    t.string "teamID", limit: 6, null: false
    t.string "lgID", limit: 4
    t.integer "inseason"
    t.integer "half", null: false
    t.integer "G"
    t.integer "W"
    t.integer "L"
    t.integer "rank"
    t.index ["lgID"], name: "ManagersHalf_lgID_idx"
  end

  create_table "legacy_parks", primary_key: "ID", id: :integer, default: -> { "nextval('\"Parks_ID_seq\"'::regclass)" }, force: :cascade do |t|
    t.string "parkalias", limit: 510
    t.string "parkkey", limit: 510
    t.string "parkname", limit: 510
    t.string "city", limit: 510
    t.string "state", limit: 510
    t.string "country", limit: 510
    t.index ["parkkey"], name: "Parks_parkkey_idx"
  end

  create_table "legacy_pitching", primary_key: ["playerID", "yearID", "stint"], force: :cascade do |t|
    t.string "playerID", limit: 18, null: false
    t.integer "yearID", null: false
    t.integer "stint", null: false
    t.string "teamID", limit: 6
    t.string "lgID", limit: 4
    t.integer "W"
    t.integer "L"
    t.integer "G"
    t.integer "GS"
    t.integer "CG"
    t.integer "SHO"
    t.integer "SV"
    t.integer "IPouts"
    t.integer "H"
    t.integer "ER"
    t.integer "HR"
    t.integer "BB"
    t.integer "SO"
    t.float "BAOpp"
    t.float "ERA"
    t.integer "IBB"
    t.integer "WP"
    t.integer "HBP"
    t.integer "BK"
    t.integer "BFP"
    t.integer "GF"
    t.integer "R"
    t.integer "SH"
    t.integer "SF"
    t.integer "GIDP"
    t.index ["lgID"], name: "Pitching_lgID_idx"
    t.index ["teamID"], name: "Pitching_teamID_idx"
  end

  create_table "legacy_pitching_post", primary_key: ["playerID", "yearID", "round"], force: :cascade do |t|
    t.string "playerID", limit: 18, null: false
    t.integer "yearID", null: false
    t.string "round", limit: 20, null: false
    t.string "teamID", limit: 6
    t.string "lgID", limit: 4
    t.integer "W"
    t.integer "L"
    t.integer "G"
    t.integer "GS"
    t.integer "CG"
    t.integer "SHO"
    t.integer "SV"
    t.integer "IPouts"
    t.integer "H"
    t.integer "ER"
    t.integer "HR"
    t.integer "BB"
    t.integer "SO"
    t.float "BAOpp"
    t.float "ERA"
    t.integer "IBB"
    t.integer "WP"
    t.integer "HBP"
    t.integer "BK"
    t.integer "BFP"
    t.integer "GF"
    t.integer "R"
    t.integer "SH"
    t.integer "SF"
    t.integer "GIDP"
    t.index ["lgID"], name: "PitchingPost_lgID_idx"
    t.index ["teamID"], name: "PitchingPost_teamID_idx"
  end

  create_table "legacy_players", primary_key: "playerID", id: :string, limit: 510, force: :cascade do |t|
    t.integer "birthYear"
    t.integer "birthMonth"
    t.integer "birthDay"
    t.string "birthCountry", limit: 510
    t.string "birthState", limit: 510
    t.string "birthCity", limit: 510
    t.integer "deathYear"
    t.integer "deathMonth"
    t.integer "deathDay"
    t.string "deathCountry", limit: 510
    t.string "deathState", limit: 510
    t.string "deathCity", limit: 510
    t.string "nameFirst", limit: 510
    t.string "nameLast", limit: 510
    t.string "nameGiven", limit: 510
    t.integer "weight"
    t.integer "height"
    t.string "bats", limit: 510
    t.string "throws", limit: 510
    t.string "debut", limit: 510
    t.string "finalGame", limit: 510
    t.string "retroID", limit: 510
    t.string "bbrefID", limit: 510
    t.index ["bbrefID"], name: "Master_bbrefID_idx"
    t.index ["retroID"], name: "Master_retroID_idx"
  end

  create_table "legacy_salaries", primary_key: ["yearID", "teamID", "lgID", "playerID"], force: :cascade do |t|
    t.integer "yearID", null: false
    t.string "teamID", limit: 6, null: false
    t.string "lgID", limit: 4, null: false
    t.string "playerID", limit: 18, null: false
    t.float "salary"
  end

  create_table "legacy_schools", primary_key: "schoolID", id: :string, limit: 30, force: :cascade do |t|
    t.string "name_full", limit: 510
    t.string "city", limit: 110
    t.string "state", limit: 110
    t.string "country", limit: 110
  end

  create_table "legacy_series_post", primary_key: ["yearID", "round"], force: :cascade do |t|
    t.integer "yearID", null: false
    t.string "round", limit: 10, null: false
    t.string "teamIDwinner", limit: 6
    t.string "lgIDwinner", limit: 4
    t.string "teamIDloser", limit: 6
    t.string "lgIDloser", limit: 4
    t.integer "wins"
    t.integer "losses"
    t.integer "ties"
  end

  create_table "legacy_teams", primary_key: ["yearID", "lgID", "teamID"], force: :cascade do |t|
    t.integer "yearID", null: false
    t.string "lgID", limit: 4, null: false
    t.string "teamID", limit: 6, null: false
    t.string "franchID", limit: 6
    t.string "divID", limit: 2
    t.integer "Rank"
    t.integer "G"
    t.integer "Ghome"
    t.integer "W"
    t.integer "L"
    t.string "DivWin", limit: 2
    t.string "WCWin", limit: 2
    t.string "LgWin", limit: 2
    t.string "WSWin", limit: 2
    t.integer "R"
    t.integer "AB"
    t.integer "H"
    t.integer "2B"
    t.integer "3B"
    t.integer "HR"
    t.integer "BB"
    t.integer "SO"
    t.integer "SB"
    t.integer "CS"
    t.integer "HBP"
    t.integer "SF"
    t.integer "RA"
    t.integer "ER"
    t.float "ERA"
    t.integer "CG"
    t.integer "SHO"
    t.integer "SV"
    t.integer "IPouts"
    t.integer "HA"
    t.integer "HRA"
    t.integer "BBA"
    t.integer "SOA"
    t.integer "E"
    t.integer "DP"
    t.float "FP"
    t.string "name", limit: 100
    t.string "park", limit: 510
    t.integer "attendance"
    t.integer "BPF"
    t.integer "PPF"
    t.string "teamIDBR", limit: 6
    t.string "teamIDlahman45", limit: 6
    t.string "teamIDretro", limit: 6
    t.index ["divID"], name: "Teams_divID_idx"
    t.index ["franchID"], name: "Teams_franchID_idx"
  end

  create_table "legacy_teams_franchises", primary_key: "franchID", id: :string, limit: 6, force: :cascade do |t|
    t.string "franchName", limit: 100
    t.string "active", limit: 4
    t.string "NAassoc", limit: 6
  end

  create_table "legacy_teams_half", primary_key: ["yearID", "teamID", "lgID", "Half"], force: :cascade do |t|
    t.integer "yearID", null: false
    t.string "lgID", limit: 4, null: false
    t.string "teamID", limit: 6, null: false
    t.string "Half", limit: 2, null: false
    t.string "divID", limit: 2
    t.string "DivWin", limit: 2
    t.integer "Rank"
    t.integer "G"
    t.integer "W"
    t.integer "L"
    t.index ["divID"], name: "TeamsHalf_divID_idx"
  end

  create_table "managers", force: :cascade do |t|
    t.integer "player_id", null: false
    t.integer "year_id", null: false
    t.string "team_code", null: false
    t.string "league_code", null: false
    t.integer "order_in_season"
    t.integer "num_g"
    t.integer "num_w"
    t.integer "num_l"
    t.integer "rank"
    t.boolean "player_manager", default: false, null: false
    t.string "lahman_player_id", null: false
    t.index ["lahman_player_id"], name: "index_managers_on_lahman_player_id"
    t.index ["league_code"], name: "index_managers_on_league_code"
    t.index ["team_code"], name: "index_managers_on_team_code"
    t.index ["year_id"], name: "index_managers_on_year_id"
  end

  create_table "pitching_stats", force: :cascade do |t|
    t.integer "player_id", null: false
    t.integer "year_id", null: false
    t.integer "stint", null: false
    t.string "team_code", null: false
    t.string "league_code", null: false
    t.integer "num_w"
    t.integer "num_l"
    t.integer "num_g"
    t.integer "num_gs"
    t.integer "num_cg"
    t.integer "num_sho"
    t.integer "num_sv"
    t.integer "num_ipouts"
    t.integer "num_h"
    t.integer "num_er"
    t.integer "num_hr"
    t.integer "num_bb"
    t.integer "num_so"
    t.decimal "baopp", precision: 4, scale: 3
    t.decimal "era", precision: 5, scale: 2
    t.integer "num_ibb"
    t.integer "num_wp"
    t.integer "num_hbp"
    t.integer "num_bk"
    t.integer "num_bfp"
    t.integer "num_gf"
    t.integer "num_r"
    t.integer "num_sh"
    t.integer "num_sf"
    t.integer "num_gidp"
    t.string "lahman_player_id", null: false
    t.index ["lahman_player_id"], name: "index_pitching_stats_on_lahman_player_id"
    t.index ["league_code"], name: "index_pitching_stats_on_league_code"
    t.index ["stint"], name: "index_pitching_stats_on_stint"
    t.index ["team_code"], name: "index_pitching_stats_on_team_code"
    t.index ["year_id"], name: "index_pitching_stats_on_year_id"
  end

  create_table "player_images", force: :cascade do |t|
    t.integer "player_id"
    t.string "lahman_bbref_id"
    t.string "bbref_url"
    t.string "public_url"
    t.string "role_prefix"
    t.index ["lahman_bbref_id"], name: "index_player_images_on_lahman_bbref_id"
    t.index ["player_id"], name: "index_player_images_on_player_id"
    t.index ["role_prefix"], name: "index_player_images_on_role_prefix"
  end

  create_table "players", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "given_name"
    t.date "birthday"
    t.string "birth_country"
    t.string "birth_state"
    t.string "birth_city"
    t.date "death"
    t.string "death_country"
    t.string "death_state"
    t.string "death_city"
    t.integer "weight"
    t.integer "height"
    t.string "bats"
    t.string "throws"
    t.date "debut"
    t.date "final_game"
    t.string "lahman_player_id", null: false
    t.string "lahman_retro_id"
    t.string "lahman_bbref_id"
    t.integer "lahman_birth_year"
    t.integer "lahman_birth_month"
    t.integer "lahman_birth_day"
    t.integer "lahman_death_year"
    t.integer "lahman_death_month"
    t.integer "lahman_death_day"
    t.string "lahman_debut"
    t.string "lahman_final_game"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_mlbp", default: true, null: false
    t.boolean "is_pitcher", default: false, null: false
    t.boolean "is_manager", default: false, null: false
    t.boolean "is_all_star", default: false, null: false
    t.boolean "is_hall_of_famer", default: false, null: false
    t.boolean "is_nlg_hall_of_famer", default: false, null: false
    t.integer "tot_g_batter"
    t.integer "tot_ab_batter"
    t.integer "tot_r_batter"
    t.integer "tot_h_batter"
    t.integer "tot_hr_batter"
    t.integer "tot_rbi_batter"
    t.integer "tot_sb_batter"
    t.integer "tot_bb_batter"
    t.integer "tot_ibb_batter"
    t.integer "tot_w_pitcher"
    t.integer "tot_l_pitcher"
    t.integer "tot_g_pitcher"
    t.integer "tot_gs_pitcher"
    t.integer "tot_cg_pitcher"
    t.integer "tot_sho_pitcher"
    t.integer "tot_sv_pitcher"
    t.integer "tot_ipouts_pitcher"
    t.integer "tot_er_pitcher"
    t.integer "tot_so_pitcher"
    t.integer "tot_g_manager"
    t.integer "tot_w_manager"
    t.integer "tot_l_manager"
    t.boolean "active", default: false, null: false
    t.boolean "has_images", default: false, null: false
    t.index ["lahman_bbref_id"], name: "index_players_on_lahman_bbref_id"
    t.index ["lahman_player_id"], name: "index_players_on_lahman_player_id"
    t.index ["lahman_retro_id"], name: "index_players_on_lahman_retro_id"
  end

  create_table "teams", force: :cascade do |t|
    t.integer "year_id", null: false
    t.string "league_code", null: false
    t.string "team_code", null: false
    t.string "franchise_code", null: false
    t.string "division_code"
    t.boolean "div_winner", default: false, null: false
    t.boolean "wc_winner", default: false, null: false
    t.boolean "lg_winner", default: false, null: false
    t.boolean "ws_winner", default: false, null: false
    t.integer "rank"
    t.integer "num_g"
    t.integer "num_gh"
    t.integer "num_w"
    t.integer "num_l"
    t.integer "num_r"
    t.integer "num_ab"
    t.integer "num_h"
    t.integer "num_2b"
    t.integer "num_3b"
    t.integer "num_hr"
    t.integer "num_bb"
    t.integer "num_so"
    t.integer "num_sb"
    t.integer "num_cs"
    t.integer "num_hbp"
    t.integer "num_sf"
    t.integer "num_ra"
    t.integer "num_er"
    t.decimal "era", precision: 5, scale: 2
    t.integer "num_cg"
    t.integer "num_sho"
    t.integer "num_sv"
    t.integer "num_ipouts"
    t.integer "num_ha"
    t.integer "num_hra"
    t.integer "num_bba"
    t.integer "num_soa"
    t.integer "num_e"
    t.integer "num_dp"
    t.decimal "fp", precision: 4, scale: 3
    t.string "name"
    t.string "park"
    t.integer "attendance"
    t.integer "bpf"
    t.integer "ppf"
    t.string "lahman_bbref_id"
    t.string "lahman_retro_id"
    t.index ["division_code"], name: "index_teams_on_division_code"
    t.index ["franchise_code"], name: "index_teams_on_franchise_code"
    t.index ["lahman_bbref_id"], name: "index_teams_on_lahman_bbref_id"
    t.index ["lahman_retro_id"], name: "index_teams_on_lahman_retro_id"
    t.index ["league_code"], name: "index_teams_on_league_code"
    t.index ["team_code"], name: "index_teams_on_team_code"
    t.index ["year_id"], name: "index_teams_on_year_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_admin", default: false, null: false
    t.string "wallet_address"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
