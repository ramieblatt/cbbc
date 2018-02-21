class CreatePacks < ActiveRecord::Migration[5.1]
  def change
    create_table :packs do |t|
      t.integer :edition_id, index: true # Edition id
      t.date :minted_at, index: true # Date pack was sold and cards were minted
      t.timestamps
    end
  end
end
