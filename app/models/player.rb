class Player < ApplicationRecord
  has_many :batting_stats, inverse_of: :player
  has_many :pitching_stats, inverse_of: :player
  has_many :fielding_stats, inverse_of: :player
  has_many :cards, inverse_of: :player
  include ActiveModel::Serialization
  paginates_per 100
end
