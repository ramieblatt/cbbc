class AddIsMintedToCards < ActiveRecord::Migration[5.1]
  def change
    add_column :cards, :is_minted, :boolean, default: false, null: false, index: true
    Card.where("token_id IS NOT NULL").update_all(is_minted: true)
  end
end
