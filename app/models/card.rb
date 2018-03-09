class Card < ApplicationRecord
  belongs_to :player, inverse_of: :cards
  belongs_to :edition, inverse_of: :cards
  belongs_to :pack, inverse_of: :cards, optional: true
  include ActiveModel::Serialization
  paginates_per 20
  CARD_TYPES = ["player", "pitcher", "manager"]
  AVERAGE_NUMBERS_PER_PLAYER = [1, 10, 100]
  PER_PLAYER_RANDOM_VARIATION = {none: 0.0, tenth: 0.1, fifth: 0.2, quarter:0.25, third: 0.3333, two_fifths: 0.4, half: 0.5, three_fifths: 0.6, two_thirds: 0.6667, three_quarters: 0.75, four_fifths: 0.8, nine_tenths: 0.9, full: 1.0}

  def series_total_for_card
    Card.where(edition_id: edition_id).where(player_id: player_id).count
  end
end
