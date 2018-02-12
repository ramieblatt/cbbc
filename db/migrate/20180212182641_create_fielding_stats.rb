class CreateFieldingStats < ActiveRecord::Migration[5.1]
  def up
    create_table :fielding_stats do |t|
      t.integer :player_id # Player id
      t.integer :year_id, null: false, index: true # Year
      t.integer :stint, null: false, index: true # Player's stint (order of appearances within a season)
      t.string :team_code, null: false, index: true # Team code
      t.string :league_code, null: false, index: true # League code
      t.string :position_code, null: false, index: true # Position code
      t.integer :num_g # Number of games
      t.integer :num_gs # Number of games started
      t.integer :num_innouts # Time played in the field expressed as outs
      t.integer :num_po # Number of putouts
      t.integer :num_a # Number of assists
      t.integer :num_e # Number of errors
      t.integer :num_dp # Number of double plays
      t.integer :num_pb # Number of passed balls (by catchers)
      t.integer :num_wp # Number of wild pitches (by catchers)
      t.integer :num_sb # Number of opponent stolen bases (by catchers)
      t.integer :num_cs # Number of opponents caught stealing (by catchers)
      t.integer :zr # Zone Rating
      t.string :lahman_player_id, null: false, index: true # A unique code assigned to each player, links the data in this file with records in the other files.
    end
    BattingStat.reset_column_information
    execute('
      INSERT INTO fielding_stats (year_id, stint, team_code, league_code, position_code, num_g, num_gs, num_innouts, num_po, num_a, num_e, num_dp, num_pb, num_wp, num_sb, num_cs, zr, lahman_player_id)
      (SELECT "legacy_fielding"."yearID" as year_id, "legacy_fielding"."stint" as stint, "legacy_fielding"."teamID" as team_code, "legacy_fielding"."lgID" as league_code, "legacy_fielding"."POS" as position_code, "legacy_fielding"."G" as num_g, "legacy_fielding"."GS" as num_gs, "legacy_fielding"."InnOuts" as num_innouts, "legacy_fielding"."PO" as num_po, "legacy_fielding"."A" as num_a, "legacy_fielding"."E" as num_e, "legacy_fielding"."DP" as num_dp, "legacy_fielding"."PB" as num_pb, "legacy_fielding"."WP" as num_wp, "legacy_fielding"."SB" as num_sb, "legacy_fielding"."CS" as num_cs, "legacy_fielding"."ZR" as zr, "legacy_fielding"."playerID" as lahman_player_id FROM legacy_fielding)
      ')
    execute('
      UPDATE fielding_stats set player_id = (SELECT players.id FROM players WHERE players.lahman_player_id = fielding_stats.lahman_player_id) WHERE player_id IS NULL
      ')
    change_column :fielding_stats, :player_id, :integer, null: false, index: true # make this a key for belongs_to
  end

  def down
    drop_table :fielding_stats
  end
end
