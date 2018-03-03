class AddMoreFlags < ActiveRecord::Migration[5.1]
  def up
    add_column :players, :active, :boolean, default: false, null: false, index: true
    Player.reset_column_information
    execute('
        UPDATE players
        SET active = true
        WHERE ( debut IS NOT NULL AND
                players.final_game >= \'2016-01-01\'
              );
      ')
  end
  def down
    remove_column :players, :active
  end
end
