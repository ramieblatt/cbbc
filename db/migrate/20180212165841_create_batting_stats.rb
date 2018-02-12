class CreateBattingStats < ActiveRecord::Migration[5.1]
  def change
    create_table :batting_stats do |t|

      t.timestamps
    end
  end
end
