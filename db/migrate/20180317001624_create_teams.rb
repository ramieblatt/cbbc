class CreateTeams < ActiveRecord::Migration[5.1]
  def up
    create_table :teams do |t|
      t.integer :year_id, null: false, index: true # Year
      t.string :league_code, null: false, index: true # League code
      t.string :team_code, null: false, index: true # Team code
      t.string :franchise_code, null: false, index: true # Team code
      t.string :division_code, index: true # Team code
      t.boolean :div_winner, default: false, null: false # Division Winner
      t.boolean :wc_winner, default: false, null: false # Wild Card Winner
      t.boolean :lg_winner, default: false, null: false # League Champion
      t.boolean :ws_winner, default: false, null: false # World Series Winner
      t.integer :rank # Position in final standings
      t.integer :num_g # Number of games played
      t.integer :num_gh # Games played at home
      t.integer :num_w # Wins
      t.integer :num_l # Losses
      t.integer :num_r # Number of runs
      t.integer :num_ab # Number of at bats
      t.integer :num_h # Number of hits
      t.integer :num_2b # Number of doubles
      t.integer :num_3b # Number of triples
      t.integer :num_hr # Number of homeruns
      t.integer :num_bb # Number of base on balls
      t.integer :num_so # Number of strikeouts
      t.integer :num_sb # Number of stolen bases
      t.integer :num_cs # Number of times caught stealing
      t.integer :num_hbp # Number of times hit by pitch
      t.integer :num_sf # Number of sacrifice flies
      t.integer :num_ra # Number of opponent runs scored
      t.integer :num_er # Number of earned runs
      t.decimal :era, precision: 5, scale: 2 # Earned run average
      t.integer :num_cg # Number of complete games
      t.integer :num_sho # Number of shutouts
      t.integer :num_sv # Number of saves
      t.integer :num_ipouts # Number of outs pitched (innings pitched x 3)
      t.integer :num_ha # Number of hits allowed
      t.integer :num_hra # Number of homeruns allowed
      t.integer :num_bba # Number of walks allowed
      t.integer :num_soa # Number of strikeouts by pitchers
      t.integer :num_e # Number of errors
      t.integer :num_dp # Number of double plays
      t.decimal :fp, precision: 4, scale: 3 # Fielding percentage
      t.string :name # Team's full name
      t.string :park # Name of team's home ballpark
      t.integer :attendance # Home attendance total
      t.integer :bpf # Three-year park factor for batters
      t.integer :ppf # Three-year park factor for pitchers
      t.string :lahman_bbref_id, index: true # Team ID used by Baseball Reference website
      t.string :lahman_retro_id, index: true # Team ID used by retrosheet
    end
    Team.reset_column_information
    execute('
      INSERT INTO teams (year_id, league_code, team_code, franchise_code, division_code, div_winner, wc_winner, lg_winner, ws_winner, rank, num_g, num_gh, num_w, num_l, num_r, num_ab, num_h, num_2b, num_3b, num_hr, num_bb, num_so, num_sb, num_cs, num_hbp, num_sf, num_ra, num_er, era, num_cg, num_sho, num_sv, num_ipouts, num_ha, num_hra, num_bba, num_soa, num_e, num_dp, fp, name, park, attendance, bpf, ppf, lahman_bbref_id, lahman_retro_id)
      (SELECT "legacy_teams"."yearID" as year_id, "legacy_teams"."lgID" as league_code, "legacy_teams"."teamID" as team_code, "legacy_teams"."franchID" as franchise_code, "legacy_teams"."divID" as division_code, (CASE "legacy_teams"."DivWin" WHEN \'Y\' THEN TRUE ELSE FALSE END) as div_winner, (CASE "legacy_teams"."WCWin" WHEN \'Y\' THEN TRUE ELSE FALSE END) as wc_winner, (CASE "legacy_teams"."LgWin" WHEN \'Y\' THEN TRUE ELSE FALSE END) as lg_winner, (CASE "legacy_teams"."WSWin" WHEN \'Y\' THEN TRUE ELSE FALSE END) as ws_winner, "legacy_teams"."Rank" as rank, "legacy_teams"."G" as num_g, "legacy_teams"."Ghome" as num_gh, "legacy_teams"."W" as num_w, "legacy_teams"."L" as num_l, "legacy_teams"."R" as num_r, "legacy_teams"."AB" as num_ab, "legacy_teams"."H" as num_h, "legacy_teams"."2B" as num_2b, "legacy_teams"."3B" as num_3b, "legacy_teams"."HR" as num_hr, "legacy_teams"."BB" as num_bb, "legacy_teams"."SO" as num_so, "legacy_teams"."SB" as num_sb, "legacy_teams"."CS" as num_cs, "legacy_teams"."HBP" as num_hbp, "legacy_teams"."SF" as num_sf, "legacy_teams"."RA" as num_ra, "legacy_teams"."ER" as num_er, "legacy_teams"."ERA" as era, "legacy_teams"."CG" as num_cg, "legacy_teams"."SHO" as num_sho, "legacy_teams"."SV" as num_sv, "legacy_teams"."IPouts" as num_ipouts, "legacy_teams"."HA" as num_ha, "legacy_teams"."HRA" as num_hra, "legacy_teams"."BBA" as num_bba, "legacy_teams"."SOA" as num_soa, "legacy_teams"."E" as num_e, "legacy_teams"."DP" as num_dp, "legacy_teams"."FP" as fp, "legacy_teams"."name" as name, "legacy_teams"."park" as park, "legacy_teams"."attendance" as attendance, "legacy_teams"."BPF" as bpf, "legacy_teams"."PPF" as ppf, "legacy_teams"."teamIDBR" as lahman_bbref_id, "legacy_teams"."teamIDretro" as lahman_retro_id FROM legacy_teams)
      ')
  end
  def down
    drop_table :teams
  end
end
