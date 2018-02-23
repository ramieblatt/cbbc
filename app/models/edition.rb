class Edition < ApplicationRecord
  has_many :cards, inverse_of: :edition
  has_many :packs, inverse_of: :edition

  validates_presence_of :number
  validates_uniqueness_of :number
  validates_presence_of :name
  validates_uniqueness_of :name

  def self.next_edition_number
    Edition.count
  end

  def create_cards(options)
    return false if is_published?
    options[:total_cards] ||= 1000
    cards.destroy_all
    Edition.connection.execute('
      INSERT INTO cards (player_id, edition_id, created_at, updated_at)
      (SELECT "players"."id" as player_id, ' + id.to_s + ', date(\''+Date.today.to_s+'\'), date(\''+Date.today.to_s+'\') FROM players ORDER BY RANDOM() LIMIT ' + options[:total_cards].to_s + ')
      ')
    return options[:total_cards]
  end

end
