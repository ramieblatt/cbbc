class CreateAuthentications < ActiveRecord::Migration[5.1]
  def change
    create_table :authentications do |t|
      t.integer :account_id, null: false, index: true
      t.string :provider, null: false, index: true
      t.string :uid, null: false, index: true
      t.timestamps null: false
    end
  end
end
