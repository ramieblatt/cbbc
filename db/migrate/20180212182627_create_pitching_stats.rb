class CreatePitchingStats < ActiveRecord::Migration[5.1]
  def up
    create_table :pitching_stats do |t|
      t.integer :player_id # Player id
      t.integer :year_id, null: false, index: true # Year
      t.integer :stint, null: false, index: true # Player's stint (order of appearances within a season)
      t.string :team_code, null: false, index: true # Team code
      t.string :league_code, null: false, index: true # League code
      t.integer :num_w # Number of wins
      t.integer :num_l # Number of losses
      t.integer :num_g # Number of games
      t.integer :num_gs # Number of games started
      t.integer :num_cg # Number of complete games
      t.integer :num_sho # Number of shutouts
      t.integer :num_sv # Number of saves
      t.integer :num_ipouts # Number of outs pitched (innings pitched x 3)
      t.integer :num_h # Number of hits
      t.integer :num_er # Number of earned runs
      t.integer :num_hr # Number of homeruns
      t.integer :num_bb # Number of walks
      t.integer :num_so # Number of strikeouts
      t.decimal :baopp, precision: 4, scale: 3 # Opponent's batting average
      t.decimal :era, precision: 5, scale: 2 # Earned run average
      t.integer :num_ibb # Number of intentional walks
      t.integer :num_wp # Number of wild pitches
      t.integer :num_hbp # Number of batters hit by pitch
      t.integer :num_bk # Number of balks
      t.integer :num_bfp # Number of batters faced by pitcher
      t.integer :num_gf # Number of games finished
      t.integer :num_r # Number of runs allowed
      t.integer :num_bfp # Number of batters faced by pitcher
      t.integer :num_sh # Number of sacrifice hits by opposing batters
      t.integer :num_sf # Number of sacrifice flies by opposing batters
      t.integer :num_gidp # Number of times grounded into double plays by opposing batters
      t.string :lahman_player_id, null: false, index: true # A unique code assigned to each player, links the data in this file with records in the other files.
    end
    PitchingStat.reset_column_information
    execute('
      INSERT INTO pitching_stats (year_id, stint, team_code, league_code, num_w, num_l, num_g, num_gs, num_cg, num_sho, num_sv, num_ipouts, num_h, num_er, num_hr, num_bb, num_so, baopp, era, num_ibb, num_wp, num_hbp, num_bk, num_bfp, num_gf, num_r, num_sh, num_sf, num_gidp, lahman_player_id)
      (SELECT "legacy_pitching"."yearID" as year_id, "legacy_pitching"."stint" as stint, "legacy_pitching"."teamID" as team_code, "legacy_pitching"."lgID" as league_code, "legacy_pitching"."W" as num_w, "legacy_pitching"."L" as num_l, "legacy_pitching"."G" as num_g, "legacy_pitching"."GS" as num_gs, "legacy_pitching"."CG" as num_cg, "legacy_pitching"."SHO" as num_sho, "legacy_pitching"."SV" as num_sv, "legacy_pitching"."IPouts" as num_ipouts, "legacy_pitching"."H" as num_h, "legacy_pitching"."ER" as num_er, "legacy_pitching"."HR" as num_hr, "legacy_pitching"."BB" as num_bb, "legacy_pitching"."SO" as num_so, "legacy_pitching"."BAOpp" as baopp, "legacy_pitching"."ERA" as era, "legacy_pitching"."IBB" as num_ibb, "legacy_pitching"."WP" as num_wp, "legacy_pitching"."HBP" as num_hbp, "legacy_pitching"."BK" as num_bk, "legacy_pitching"."BFP" as num_bfp, "legacy_pitching"."GF" as num_gf, "legacy_pitching"."R" as num_r, "legacy_pitching"."SH" as num_sh, "legacy_pitching"."SF" as num_sf, "legacy_pitching"."GIDP" as num_gidp, "legacy_pitching"."playerID" as lahman_player_id FROM legacy_pitching)
      ')
    execute('
      UPDATE pitching_stats set player_id = (SELECT players.id FROM players WHERE players.lahman_player_id = pitching_stats.lahman_player_id) WHERE player_id IS NULL
      ')
    change_column :pitching_stats, :player_id, :integer, null: false, index: true # make this a key for belongs_to
  end

  def down
    drop_table :pitching_stats
  end
end
