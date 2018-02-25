class CreateAppearances < ActiveRecord::Migration[5.1]
  def up
    create_table :appearances do |t|
      t.integer :player_id # Player id
      t.integer :year_id, null: false, index: true # Year
      t.string :team_code, null: false, index: true # Team code
      t.string :league_code, null: false, index: true # League code
      t.integer :num_g # Number of games
      t.integer :num_gs # Number of games started
      t.integer :num_gb # Number of games in which player batted
      t.integer :num_gd # Number of games in which player appeared on defense
      t.integer :num_gp # Number of games as pitcher
      t.integer :num_gc # Number of games as catcher
      t.integer :num_g1b # Number of games as firstbaseman
      t.integer :num_g2b # Number of games as secondbaseman
      t.integer :num_g3b # Number of games as thirdbaseman
      t.integer :num_gss # Number of games as shortstop
      t.integer :num_glf # Number of games as leftfielder
      t.integer :num_gcf # Number of games as centerfielder
      t.integer :num_grf # Number of games as right fielder
      t.integer :num_gof # Number of games as outfielder
      t.integer :num_gdh # Number of games as designated hitter
      t.integer :num_gph # Number of games as pinch hitter
      t.integer :num_gpr # Number of games as pinch runner
      t.string :lahman_player_id, null: false, index: true # A unique code assigned to each player, links the data in this file with records in the other files.
    end
    Appearance.reset_column_information
    execute('
      INSERT INTO appearances (year_id, team_code, league_code, num_g, num_gs, num_gb, num_gd, num_gp, num_gc, num_g1b, num_g2b, num_g3b, num_gss, num_glf, num_gcf, num_grf, num_gof, num_gdh, num_gph, num_gpr, lahman_player_id)
      (SELECT "legacy_appearances"."yearID" as year_id, "legacy_appearances"."teamID" as team_code, "legacy_appearances"."lgID" as league_code, "legacy_appearances"."G_all" as num_g, "legacy_appearances"."GS" as num_gs, "legacy_appearances"."G_batting" as num_gb, "legacy_appearances"."G_defense" as num_gd, "legacy_appearances"."G_p" as num_gp, "legacy_appearances"."G_c" as num_gc, "legacy_appearances"."G_1b" as num_g1b, "legacy_appearances"."G_2b" as num_g2b, "legacy_appearances"."G_3b" as num_g3b, "legacy_appearances"."G_ss" as num_gss, "legacy_appearances"."G_lf" as num_glf, "legacy_appearances"."G_cf" as num_gcf, "legacy_appearances"."G_rf" as num_grf, "legacy_appearances"."G_of" as num_gof, "legacy_appearances"."G_dh" as num_gdh, "legacy_appearances"."G_ph" as num_gph, "legacy_appearances"."G_pr" as num_gpr, "legacy_appearances"."playerID" as lahman_player_id FROM legacy_appearances)
      ')
    execute('
      UPDATE appearances set player_id = (SELECT players.id FROM players WHERE players.lahman_player_id = appearances.lahman_player_id) WHERE player_id IS NULL
      ')
    change_column :appearances, :player_id, :integer, null: false, index: true # make this a key for belongs_to
  end

  def down
    drop_table :appearances
  end
end
