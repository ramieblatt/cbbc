class CreateHallOfFameAppearances < ActiveRecord::Migration[5.1]
  def up
    create_table :hall_of_fame_appearances do |t|
      t.integer :player_id # Player id
      t.integer :year_id, null: false, index: true # Year
      t.string :voted_by, null: false, index: true # Method by which player was voted upon
      t.integer :ballots # Total ballots cast in that year
      t.integer :needed # Number of votes needed for selection in that year
      t.integer :votes # Total votes received
      t.boolean :inducted, default: false, null: false # Whether player was inducted by that vote or not
      t.string :category, null: false, index: true # Category in which candidate was honored
      t.string :needed_note # Explanation of qualifiers for special elections
      t.string :lahman_player_id, null: false, index: true # A unique code assigned to each player, links the data in this file with records in the other files.
    end
    HallOfFameAppearance.reset_column_information
    execute('
      INSERT INTO hall_of_fame_appearances (year_id, voted_by, ballots, needed, votes, inducted, category, needed_note, lahman_player_id)
      (SELECT "legacy_hall_of_fame"."yearid" as year_id, "legacy_hall_of_fame"."votedBy" as voted_by, "legacy_hall_of_fame"."ballots" as ballots, "legacy_hall_of_fame"."needed" as needed, "legacy_hall_of_fame"."votes" as votes, (CASE "legacy_hall_of_fame"."inducted" WHEN \'Y\' THEN TRUE ELSE FALSE END) as inducted, "legacy_hall_of_fame"."category" as category, "legacy_hall_of_fame"."needed_note" as needed_note, "legacy_hall_of_fame"."playerID" as lahman_player_id FROM legacy_hall_of_fame)
      ')
    execute('
      UPDATE hall_of_fame_appearances set player_id = (SELECT players.id FROM players WHERE players.lahman_player_id = hall_of_fame_appearances.lahman_player_id) WHERE player_id IS NULL
      ')
    execute('
      DELETE FROM hall_of_fame_appearances WHERE player_id IS NULL
      ')
    change_column :hall_of_fame_appearances, :player_id, :integer, null: false, index: true # make this a key for belongs_to
  end

  def down
    drop_table :hall_of_fame_appearances
  end
end
