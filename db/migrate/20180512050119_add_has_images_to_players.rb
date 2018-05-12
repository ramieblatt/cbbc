class AddHasImagesToPlayers < ActiveRecord::Migration[5.1]
  def up
    add_column :players, :has_images, :boolean, default: false, null: false, index: true
    Player.reset_column_information
    execute('
        UPDATE players
        SET has_images = true
        WHERE ( id IN (SELECT player_id FROM player_images) );
      ')
  end
  def down
    remove_column :players, :has_images
  end
end
