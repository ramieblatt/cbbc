class CreatePlayers < ActiveRecord::Migration[5.1]
  def up
    create_table :players do |t|
      t.string :first_name # Player's first name
      t.string :last_name # Player's last name
      t.string :given_name # Player's given name (typically first and middle)
      t.date :birthday # Date player was born
      t.string :birth_country # Country where player was born
      t.string :birth_state # State where player was born
      t.string :birth_city # City where player was born
      t.date :death # Date player died
      t.string :death_country # Country where player died
      t.string :death_state # State where player died
      t.string :death_city # City where player died
      t.integer :weight # Player's weight in pounds
      t.integer :height # Player's height in inches
      t.string :bats # Player's batting hand (left, right, or both)
      t.string :throws # Player's throwing hand (left or right)
      t.date :debut # Date that player made first major league appearance
      t.date :final_game # Date that player made first major league appearance (blank if still active)
      t.string :lahman_player_id, null: false, index: true # A unique code assigned to each player, links the data in this file with records in the other files.
      t.string :lahman_retro_id, index: true # ID used by retrosheet
      t.string :lahman_bbref_id, index: true # ID used by Baseball Reference website
      t.integer :lahman_birth_year # Year player was born
      t.integer :lahman_birth_month # Month player was born
      t.integer :lahman_birth_day # Day player was born
      t.integer :lahman_death_year # Year player died
      t.integer :lahman_death_month # Month player died
      t.integer :lahman_death_day # Day player died
      t.string :lahman_debut # Date that player made first major league appearance (string)
      t.string :lahman_final_game # Date that player made first major league appearance (string, blank if still active)
      t.timestamps
    end

    Player.reset_column_information
    execute('
      INSERT INTO players (first_name, last_name, given_name, birthday, birth_country, birth_state, birth_city, death, death_country, death_state, death_city, weight, height, bats, throws, debut, final_game, lahman_player_id, lahman_retro_id, lahman_bbref_id, lahman_birth_year, lahman_birth_month, lahman_birth_day, lahman_death_year, lahman_death_month, lahman_death_day, lahman_debut, lahman_final_game, created_at, updated_at)
      (SELECT "legacy_players"."nameFirst" as first_name, "legacy_players"."nameLast" as last_name, "legacy_players"."nameGiven" as given_name, make_date("legacy_players"."birthYear", "legacy_players"."birthMonth", "legacy_players"."birthDay") as birthday, "legacy_players"."birthCountry" as birth_country, "legacy_players"."birthState" as birth_state, "legacy_players"."birthCity" as birth_city, make_date("legacy_players"."deathYear", "legacy_players"."deathMonth", "legacy_players"."deathDay") as death, "legacy_players"."deathCountry" as death_country, "legacy_players"."deathState" as death_state, "legacy_players"."deathCity" as death_city, "legacy_players"."weight" as weight, "legacy_players"."height" as height, "legacy_players"."bats" as bats, "legacy_players"."throws" as throws, date("legacy_players"."debut") as debut, date("legacy_players"."finalGame") as final_game, "legacy_players"."playerID" as lahman_player_id, "legacy_players"."retroID" as lahman_retro_id, "legacy_players"."bbrefID" as lahman_bbref_id, "legacy_players"."birthYear" as lahman_birth_year, "legacy_players"."birthMonth" as lahman_birth_month, "legacy_players"."birthDay" as lahman_birth_day, "legacy_players"."deathYear" as lahman_death_year, "legacy_players"."deathMonth" as lahman_death_month, "legacy_players"."deathDay" as lahman_death_day, "legacy_players"."debut" as lahman_debut, "legacy_players"."finalGame" as lahman_final_game, date(\''+Date.today.to_s+'\'), date(\''+Date.today.to_s+'\') FROM legacy_players)
      ')
  end

  def down
    drop_table :players
  end
end
