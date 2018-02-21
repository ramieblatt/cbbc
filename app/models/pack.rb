class Pack < ApplicationRecord
  belongs_to :edition, inverse_of: :packs
  has_many :cards, inverse_of: :pack
end
