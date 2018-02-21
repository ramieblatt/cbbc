class CreateEditions < ActiveRecord::Migration[5.1]
  def change
    create_table :editions do |t|
      t.string :name, null: false, index: true # Edition name should be unique
      t.integer :number, null: false, index: true # Should essentially match id - 1, but an integer starting at 0
      t.timestamps
    end
  end
end
