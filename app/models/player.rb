class Player < ApplicationRecord
  has_many :batting_stats, inverse_of: :player
  has_many :pitching_stats, inverse_of: :player
  has_many :fielding_stats, inverse_of: :player
  has_many :appearances, inverse_of: :player
  has_many :all_star_appearances, inverse_of: :player
  has_many :hall_of_fame_appearances, inverse_of: :player
  has_many :managers, inverse_of: :player
  has_many :cards, inverse_of: :player
  include ActiveModel::Serialization
  paginates_per 20
  DATABASE_EDITION_YEAR = "2016"

  scope :active, -> { where("players.debut IS NOT NULL AND (players.final_game >= ?)", Date.parse("#{DATABASE_EDITION_YEAR}-01-01")) } # only way to derive from data is to assume active if they played during the db edition year, there are ~200 records where debut and final game are null, so skip those
  scope :non_active, -> { where("players.debut IS NOT NULL AND (players.final_game < ?)", Date.parse("#{DATABASE_EDITION_YEAR}-01-01")) }
  # scope :pitchers, -> { where("EXISTS (select distinct p.id from players p inner join fielding_stats fs on fs.player_id = p.id where fs.position_code = 'P')") }
  # scope :non_pitchers, -> { where("NOT EXISTS (select distinct p.id from players p inner join pitching_stats ps on ps.player_id = p.id)") }
  scope :non_pitchers, -> { where(id: Player.joins(:fielding_stats).where("fielding_stats.position_code <> 'P'").pluck("distinct players.id")) }
  scope :pitchers, -> { where(id: Player.joins(:fielding_stats).where("fielding_stats.position_code = 'P'").pluck("distinct players.id")) }
  scope :with_career_num_ab_greater_than, -> (tot_ab) { where(id: Player.select("players.id, SUM(batting_stats.num_ab)").joins(:batting_stats).group("players.id").having("SUM(batting_stats.num_ab) > ?", tot_ab).pluck("distinct players.id")) }
  scope :with_career_num_ab_less_than, -> (tot_ab) { where(id: Player.select("players.id, SUM(batting_stats.num_ab)").joins(:batting_stats).group("players.id").having("SUM(batting_stats.num_ab) < ?", tot_ab).pluck("distinct players.id")) }
  scope :with_career_num_ips_greater_than, -> (tot_ips) { Player.with_career_num_ipouts_greater_than(tot_ips*3) }
  scope :with_career_num_ips_less_than, -> (tot_ips) { Player.with_career_num_ipouts_less_than(tot_ips*3) }
  scope :with_career_num_ipouts_greater_than, -> (tot_ipouts) { where(id: Player.select("players.id, SUM(pitching_stats.num_ipouts)").joins(:pitching_stats).group("players.id").having("SUM(pitching_stats.num_ipouts) > ?", tot_ipouts).pluck("distinct players.id")) }
  scope :with_career_num_ipouts_less_than, -> (tot_ipouts) { where(id: Player.select("players.id, SUM(pitching_stats.num_ipouts)").joins(:pitching_stats).group("players.id").having("SUM(pitching_stats.num_ipouts) < ?", tot_ipouts).pluck("distinct players.id")) }
  scope :with_career_num_sv_greater_than, -> (tot_sv) { where(id: Player.select("players.id, SUM(pitching_stats.num_sv)").joins(:pitching_stats).group("players.id").having("SUM(pitching_stats.num_sv) > ?", tot_sv).pluck("distinct players.id")) }
  scope :with_career_num_sv_less_than, -> (tot_sv) { where(id: Player.select("players.id, SUM(pitching_stats.num_sv)").joins(:pitching_stats).group("players.id").having("SUM(pitching_stats.num_sv) < ?", tot_sv).pluck("distinct players.id")) }
  scope :with_career_winning_percentage_greater_than, -> (win_percentage) { where(id: Player.select("players.id, cast(SUM(pitching_stats.num_w) as decimal) / (SUM(pitching_stats.num_w)+SUM(pitching_stats.num_l))").joins(:pitching_stats).group("players.id").having("cast(SUM(pitching_stats.num_w) as decimal) / (SUM(pitching_stats.num_w)+SUM(pitching_stats.num_l)) > ?", win_percentage).pluck("distinct players.id")) }
  scope :hall_of_famers, -> { where(id: Player.joins(:hall_of_fame_appearances).where("hall_of_fame_appearances.inducted IS TRUE").pluck("distinct players.id")) }
  scope :all_stars, -> { where(id: Player.joins(:all_star_appearances).where("all_star_appearances.played IS TRUE").pluck("distinct players.id")) }
  scope :top_managers, -> (lim) { ids = Player.find_by_sql(["select players.id from players left join (select player_id, sum(num_w) as w_sum from managers group by player_id) as sums on players.id = sums.player_id where sums.w_sum > 1 order by sums.w_sum DESC LIMIT ?", lim]).pluck(:id); Player.where(id: ids).order("position(id::text in '#{ids.join(',')}')") } # need to do this to get correct sorting and performance
  scope :negro_league_hall_of_famers, -> { where(id: Player.joins(:hall_of_fame_appearances).where("hall_of_fame_appearances.inducted IS TRUE AND hall_of_fame_appearances.voted_by = 'Negro League'").pluck("distinct players.id")) }

  def self.position_code_select_options
    FieldingStat.pluck("distinct position_code").sort_by{|pos_code| pos_code}.map{|pos_code| [pos_code]}
  end
end
