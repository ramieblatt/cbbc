class AddTokenIdToCards < ActiveRecord::Migration[5.1]
  def change
    add_column :cards, :token_id, :integer, index: true
  end
end
