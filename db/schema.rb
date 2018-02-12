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

ActiveRecord::Schema.define(version: 20180212052107) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "AllstarFull", primary_key: ["playerID", "yearID", "gameNum"], force: :cascade do |t|
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

  create_table "Appearances", primary_key: ["yearID", "teamID", "playerID"], force: :cascade do |t|
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

  create_table "AwardsManagers", primary_key: ["yearID", "awardID", "lgID", "playerID"], force: :cascade do |t|
    t.string "playerID", limit: 20, null: false
    t.string "awardID", limit: 150, null: false
    t.integer "yearID", null: false
    t.string "lgID", limit: 4, null: false
    t.string "tie", limit: 2
    t.string "notes", limit: 200
  end

  create_table "AwardsPlayers", primary_key: ["yearID", "awardID", "lgID", "playerID"], force: :cascade do |t|
    t.string "playerID", limit: 18, null: false
    t.string "awardID", limit: 510, null: false
    t.integer "yearID", null: false
    t.string "lgID", limit: 4, null: false
    t.string "tie", limit: 2
    t.string "notes", limit: 200
  end

  create_table "AwardsShareManagers", primary_key: ["awardID", "yearID", "lgID", "playerID"], force: :cascade do |t|
    t.string "awardID", limit: 50, null: false
    t.integer "yearID", null: false
    t.string "lgID", limit: 4, null: false
    t.string "playerID", limit: 20, null: false
    t.integer "pointsWon"
    t.integer "pointsMax"
    t.integer "votesFirst"
  end

  create_table "AwardsSharePlayers", primary_key: ["awardID", "yearID", "lgID", "playerID"], force: :cascade do |t|
    t.string "awardID", limit: 50, null: false
    t.integer "yearID", null: false
    t.string "lgID", limit: 4, null: false
    t.string "playerID", limit: 18, null: false
    t.float "pointsWon"
    t.integer "pointsMax"
    t.float "votesFirst"
  end

  create_table "Batting", primary_key: ["playerID", "yearID", "stint"], force: :cascade do |t|
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

  create_table "BattingPost", primary_key: ["yearID", "round", "playerID"], force: :cascade do |t|
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

  create_table "CollegePlaying", id: false, force: :cascade do |t|
    t.string "playerID", limit: 18, null: false
    t.string "schoolID", limit: 30
    t.integer "yearID"
  end

  create_table "Fielding", primary_key: ["playerID", "yearID", "stint", "POS"], force: :cascade do |t|
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

  create_table "FieldingOF", primary_key: ["playerID", "yearID", "stint"], force: :cascade do |t|
    t.string "playerID", limit: 18, null: false
    t.integer "yearID", null: false
    t.integer "stint", null: false
    t.integer "Glf"
    t.integer "Gcf"
    t.integer "Grf"
  end

  create_table "FieldingOFsplit", primary_key: ["playerID", "yearID", "stint", "POS"], force: :cascade do |t|
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

  create_table "FieldingPost", primary_key: ["playerID", "yearID", "round", "POS"], force: :cascade do |t|
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

  create_table "HallOfFame", primary_key: ["playerID", "yearid", "votedBy"], force: :cascade do |t|
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

  create_table "HomeGames", id: false, force: :cascade do |t|
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

  create_table "Managers", primary_key: ["yearID", "teamID", "inseason"], force: :cascade do |t|
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

  create_table "ManagersHalf", primary_key: ["yearID", "teamID", "playerID", "half"], force: :cascade do |t|
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

  create_table "Parks", primary_key: "ID", id: :serial, force: :cascade do |t|
    t.string "parkalias", limit: 510
    t.string "parkkey", limit: 510
    t.string "parkname", limit: 510
    t.string "city", limit: 510
    t.string "state", limit: 510
    t.string "country", limit: 510
    t.index ["parkkey"], name: "Parks_parkkey_idx"
  end

  create_table "Pitching", primary_key: ["playerID", "yearID", "stint"], force: :cascade do |t|
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

  create_table "PitchingPost", primary_key: ["playerID", "yearID", "round"], force: :cascade do |t|
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

  create_table "Salaries", primary_key: ["yearID", "teamID", "lgID", "playerID"], force: :cascade do |t|
    t.integer "yearID", null: false
    t.string "teamID", limit: 6, null: false
    t.string "lgID", limit: 4, null: false
    t.string "playerID", limit: 18, null: false
    t.float "salary"
  end

  create_table "Schools", primary_key: "schoolID", id: :string, limit: 30, force: :cascade do |t|
    t.string "name_full", limit: 510
    t.string "city", limit: 110
    t.string "state", limit: 110
    t.string "country", limit: 110
  end

  create_table "SeriesPost", primary_key: ["yearID", "round"], force: :cascade do |t|
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

  create_table "Teams", primary_key: ["yearID", "lgID", "teamID"], force: :cascade do |t|
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

  create_table "TeamsFranchises", primary_key: "franchID", id: :string, limit: 6, force: :cascade do |t|
    t.string "franchName", limit: 100
    t.string "active", limit: 4
    t.string "NAassoc", limit: 6
  end

  create_table "TeamsHalf", primary_key: ["yearID", "teamID", "lgID", "Half"], force: :cascade do |t|
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
    t.index ["lahman_bbref_id"], name: "index_players_on_lahman_bbref_id"
    t.index ["lahman_player_id"], name: "index_players_on_lahman_player_id"
    t.index ["lahman_retro_id"], name: "index_players_on_lahman_retro_id"
  end

end
