class Edition < ApplicationRecord
  has_many :cards, inverse_of: :edition
  has_many :packs, inverse_of: :edition

  validates_presence_of :number
  validates_presence_of :name

end
