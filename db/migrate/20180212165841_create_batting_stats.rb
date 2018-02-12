class CreateBattingStats < ActiveRecord::Migration[5.1]
  def up
    create_table :batting_stats do |t|
      t.integer :player_id # Player id
      t.integer :year_id, null: false, index: true # Year
      t.integer :stint, null: false, index: true # Player's stint (order of appearances within a season)
      t.string :team_code, null: false, index: true # Team code
      t.string :league_code, null: false, index: true # League code
      t.integer :num_g # Number of games
      t.integer :num_ab # Number of at bats
      t.integer :num_r # Number of runs
      t.integer :num_h # Number of hits
      t.integer :num_2b # Number of doubles
      t.integer :num_3b # Number of triples
      t.integer :num_hr # Number of homeruns
      t.integer :num_rbi # Number of runs batted in
      t.integer :num_sb # Number of stolen bases
      t.integer :num_cs # Number of times caught stealing
      t.integer :num_bb # Number of base on balls
      t.integer :num_so # Number of strikeouts
      t.integer :num_ibb # Number of intentional walks
      t.integer :num_hbp # Number of times hit by pitch
      t.integer :num_sh # Number of sacrifice hits
      t.integer :num_sf # Number of sacrifice flies
      t.integer :num_gidp # Number of times grounded into double plays
      t.string :lahman_player_id, null: false, index: true # A unique code assigned to each player, links the data in this file with records in the other files.
    end
    BattingStat.reset_column_information
    execute('
      INSERT INTO batting_stats (year_id, stint, team_code, league_code, num_g, num_ab, num_r, num_h, num_2b, num_3b, num_hr, num_rbi, num_sb, num_cs, num_bb, num_so, num_ibb, num_hbp, num_sh, num_sf, num_gidp, lahman_player_id)
      (SELECT "legacy_batting"."yearID" as year_id, "legacy_batting"."stint" as stint, "legacy_batting"."teamID" as team_code, "legacy_batting"."lgID" as league_code, "legacy_batting"."G" as num_g, "legacy_batting"."AB" as num_ab, "legacy_batting"."R" as num_r, "legacy_batting"."H" as num_h, "legacy_batting"."2B" as num_2b, "legacy_batting"."3B" as num_3b, "legacy_batting"."HR" as num_hr, "legacy_batting"."RBI" as num_rbi, "legacy_batting"."SB" as num_sb, "legacy_batting"."CS" as num_cs, "legacy_batting"."BB" as num_bb, "legacy_batting"."SO" as num_so, "legacy_batting"."IBB" as num_ibb, "legacy_batting"."HBP" as num_hbp, "legacy_batting"."SH" as num_sh, "legacy_batting"."SF" as num_sf, "legacy_batting"."GIDP" as num_gidp, "legacy_batting"."playerID" as lahman_player_id FROM legacy_batting)
      ')
    execute('
      UPDATE batting_stats set player_id = (SELECT players.id FROM players WHERE players.lahman_player_id = batting_stats.lahman_player_id) WHERE player_id IS NULL
      ')
    change_column :batting_stats, :player_id, :integer, null: false, index: true # make this a key for belongs_to
  end

  def down
    drop_table :batting_stats
  end
end
