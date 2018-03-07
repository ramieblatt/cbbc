class Card < ApplicationRecord
  belongs_to :player, inverse_of: :cards
  belongs_to :edition, inverse_of: :cards
  belongs_to :pack, inverse_of: :cards, optional: true
  include ActiveModel::Serialization
  paginates_per 20
  AVERAGE_NUMBERS_PER_PLAYER = [1, 10, 100]

  def series_total_for_card
    Card.where(edition_id: edition_id).where(player_id: player_id).count
  end
end
