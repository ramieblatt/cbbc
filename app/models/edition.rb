class Edition < ApplicationRecord
  has_many :cards, inverse_of: :edition
  has_many :packs, inverse_of: :edition
end
