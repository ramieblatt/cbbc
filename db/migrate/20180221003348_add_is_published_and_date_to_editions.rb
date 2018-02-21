class AddIsPublishedAndDateToEditions < ActiveRecord::Migration[5.1]
  def up
    add_column :editions, :is_published, :boolean, default: false, null: false
    add_column :editions, :published_at, :datetime
  end
end
