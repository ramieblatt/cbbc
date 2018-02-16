class Player < ApplicationRecord
  paginates_per 100
  has_many :batting_stats
  has_many :pitching_stats
  has_many :fielding_stats
end
