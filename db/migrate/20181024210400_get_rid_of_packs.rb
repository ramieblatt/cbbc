class GetRidOfPacks < ActiveRecord::Migration[5.1]
  def change
    remove_column :cards, :pack_id
    drop_table :packs
  end
end
