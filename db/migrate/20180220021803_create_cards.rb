class CreateCards < ActiveRecord::Migration[5.1]
  def change
    create_table :cards do |t|
      t.integer :player_id, null: false, index: true # Player id
      t.integer :edition_id, null: false, index: true # Edition id
      t.integer :pack_id, index: true # Pack id, if any
      t.date :minted_at, index: true # Date card was minted
      t.integer :series_index, null: false, default: 1, index: true # Card number series_index of total_cards_in_series
      t.integer :total_cards_in_series, null: false, default: 1 # Total number of same player cards in the series
      t.timestamps
    end
  end
end
