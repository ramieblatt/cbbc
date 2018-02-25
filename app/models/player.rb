class Player < ApplicationRecord
  has_many :batting_stats, inverse_of: :player
  has_many :pitching_stats, inverse_of: :player
  has_many :fielding_stats, inverse_of: :player
  has_many :appearances, inverse_of: :player
  has_many :all_star_appearances, inverse_of: :player
  has_many :hall_of_fame_appearances, inverse_of: :player
  has_many :cards, inverse_of: :player
  include ActiveModel::Serialization
  paginates_per 100
  DATABASE_EDITION_YEAR = "2016"

  scope :active, -> { where("players.debut IS NOT NULL AND (players.final_game >= ?)", Date.parse("#{DATABASE_EDITION_YEAR}-01-01")) } # only way to derive from data is to assume active if they played during the db edition year, there are ~200 records where debut and final game are null, so skip those
  scope :non_active, -> { where("players.debut IS NOT NULL AND (players.final_game < ?)", Date.parse("#{DATABASE_EDITION_YEAR}-01-01")) }
  # scope :pitchers, -> { where("EXISTS (select distinct p.id from players p inner join fielding_stats fs on fs.player_id = p.id where fs.position_code = 'P')") }
  scope :non_pitchers, -> { where("NOT EXISTS (select distinct p.id from players p inner join pitching_stats ps on ps.player_id = p.id)") }
  scope :pitchers, -> { where(id: Player.joins(:fielding_stats).where("fielding_stats.position_code = 'P'").pluck("distinct players.id")) }
  scope :with_career_num_ab_greater_than, -> (tot_ab) { where(id: Player.select("players.id, SUM(batting_stats.num_ab)").joins(:batting_stats).group("players.id").having("SUM(batting_stats.num_ab) > ?", tot_ab).pluck("distinct players.id")) }
  scope :with_career_num_ab_less_than, -> (tot_ab) { where(id: Player.select("players.id, SUM(batting_stats.num_ab)").joins(:batting_stats).group("players.id").having("SUM(batting_stats.num_ab) < ?", tot_ab).pluck("distinct players.id")) }
  scope :with_career_num_ips_greater_than, -> (tot_ips) { Player.with_career_num_ipouts_greater_than(tot_ips*3) }
  scope :with_career_num_ipouts_greater_than, -> (tot_ipouts) { where(id: Player.select("players.id, SUM(pitching_stats.num_ipouts)").joins(:pitching_stats).group("players.id").having("SUM(pitching_stats.num_ipouts) > ?", tot_ipouts).pluck("distinct players.id")) }
  scope :with_career_winning_percentage_greater_than, -> (win_percentage) { where(id: Player.select("players.id, cast(SUM(pitching_stats.num_w) as decimal) / (SUM(pitching_stats.num_w)+SUM(pitching_stats.num_l))").joins(:pitching_stats).group("players.id").having("cast(SUM(pitching_stats.num_w) as decimal) / (SUM(pitching_stats.num_w)+SUM(pitching_stats.num_l)) > ?", win_percentage).pluck("distinct players.id")) }
  scope :with_career_num_sv_greater_than, -> (tot_sv) { where(id: Player.select("players.id, SUM(pitching_stats.num_sv)").joins(:pitching_stats).group("players.id").having("SUM(pitching_stats.num_sv) > ?", tot_sv).pluck("distinct players.id")) }
  scope :hall_of_famers, -> { joins(:hall_of_fame_appearances).where("hall_of_fame_appearances.inducted IS TRUE") }
end
  # scope :contains_item_ids, ->(item_ids) { where("EXISTS (select li.id from line_items li inner join catalog_items ci on ci.id= li.catalog_item_id inner join store_items si on si.id = ci.store_item_id where li.resource_id = quotes.id and li.resource_type = 'Quote' and si.item_id IN (?))", item_ids) }
