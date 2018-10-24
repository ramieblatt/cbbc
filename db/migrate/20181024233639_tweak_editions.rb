class TweakEditions < ActiveRecord::Migration[5.1]
  def change
    change_column_null :editions, :number, true
  end
end
