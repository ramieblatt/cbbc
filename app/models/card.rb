class Card < ApplicationRecord
  belongs_to :player, inverse_of: :cards
  belongs_to :edition, inverse_of: :cards
  belongs_to :pack, inverse_of: :cards
end
