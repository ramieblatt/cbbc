class CreatePlayerImages < ActiveRecord::Migration[5.1]
  def up
    create_table :player_images do |t|
      t.integer :player_id, index: true # belongs to player
      t.string :lahman_bbref_id, index: true # ID used by Baseball Reference website
      t.string :bbref_url # URL in Baseball Reference website
      t.string :public_url # URL of the image, eventually in our B2 Backblaze or Amazon S3 cloud server
      t.string :role_prefix, index: true # either 'players', 'nonmlbpa' or 'managers'
    end
  end
  def down
    drop_table :player_images
  end
end
