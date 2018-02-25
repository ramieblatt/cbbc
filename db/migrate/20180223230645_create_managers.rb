class CreateManagers < ActiveRecord::Migration[5.1]
  def up
    create_table :managers do |t|
      t.integer :player_id # Player id
      t.integer :year_id, null: false, index: true # Year
      t.string :team_code, null: false, index: true # Team code
      t.string :league_code, null: false, index: true # League code
      t.integer :order_in_season # Managerial order.  Zero if the individual managed the team
                                 # the entire year.  Otherwise denotes where the manager appeared
                                 # in the managerial order (1 for first manager, 2 for second, etc.)
      t.integer :num_g # Number of games managed
      t.integer :num_w # Number of wins
      t.integer :num_l # Number of losses
      t.integer :rank # Team's final position in standings that year
      t.boolean :player_manager, default: false, null: false # Whether manager was player manager
      t.string :lahman_player_id, null: false, index: true # A unique code assigned to each player, links the data in this file with records in the other files.
    end
    Manager.reset_column_information
    execute('
      INSERT INTO managers (year_id, team_code, league_code, order_in_season, num_g, num_w, num_l, rank, player_manager, lahman_player_id)
      (SELECT "legacy_managers"."yearID" as year_id, "legacy_managers"."teamID" as team_code, "legacy_managers"."lgID" as league_code, "legacy_managers"."inseason" as order_in_season, "legacy_managers"."G" as num_g, "legacy_managers"."W" as num_w, "legacy_managers"."L" as num_l, "legacy_managers"."rank" as rank, (CASE "legacy_managers"."plyrMgr" WHEN \'Y\' THEN TRUE ELSE FALSE END) as player_manager, "legacy_managers"."playerID" as lahman_player_id FROM legacy_managers)
      ')
    execute('
      UPDATE managers set player_id = (SELECT players.id FROM players WHERE players.lahman_player_id = managers.lahman_player_id) WHERE player_id IS NULL
      ')
    change_column :managers, :player_id, :integer, null: false, index: true # make this a key for belongs_to
  end

  def down
    drop_table :managers
  end
end
