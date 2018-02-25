class CreateAllStarAppearances < ActiveRecord::Migration[5.1]
  def up
    create_table :all_star_appearances do |t|
      t.integer :player_id # Player id
      t.integer :year_id, null: false, index: true # Year
      t.string :game_number, null: false, index: true # Game number (zero if only one All-Star game played that season)
      t.string :game_code, index: true # Retrosheet ID for the game
      t.string :team_code, null: false, index: true # Team code
      t.string :league_code, null: false, index: true # League code
      t.boolean :played, default: false, null: false # True if player played in the game
      t.integer :starting_pos # If player was game starter, the position played
      t.string :lahman_player_id, null: false, index: true # A unique code assigned to each player, links the data in this file with records in the other files.
    end
    AllStarAppearance.reset_column_information
    execute('
      INSERT INTO all_star_appearances (year_id, game_number, game_code, team_code, league_code, played, starting_pos, lahman_player_id)
      (SELECT "legacy_all_star_full"."yearID" as year_id, "legacy_all_star_full"."gameNum" as game_number, "legacy_all_star_full"."gameID" as game_code, "legacy_all_star_full"."teamID" as team_code, "legacy_all_star_full"."lgID" as league_code, (CASE "legacy_all_star_full"."GP" WHEN 1 THEN TRUE ELSE FALSE END) as played, "legacy_all_star_full"."startingPos" as starting_pos, "legacy_all_star_full"."playerID" as lahman_player_id FROM legacy_all_star_full)
      ')
    execute('
      UPDATE all_star_appearances set player_id = (SELECT players.id FROM players WHERE players.lahman_player_id = all_star_appearances.lahman_player_id) WHERE player_id IS NULL
      ')
    change_column :all_star_appearances, :player_id, :integer, null: false, index: true # make this a key for belongs_to
  end

  def down
    drop_table :all_star_appearances
  end
end
