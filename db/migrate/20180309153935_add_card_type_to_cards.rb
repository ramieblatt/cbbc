class AddCardTypeToCards < ActiveRecord::Migration[5.1]
  def up
    add_column :cards, :card_type, :string, default: 'player', null: false, index: true # here we can have player, pitcher, manager
  end
  def down
    remove_column :cards, :card_type
  end
end
