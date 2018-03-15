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
  PREBUILT_QUERIES = [
    "with_career_num_ab_greater_than",
    "with_career_num_ab_less_than",
    "with_career_num_ips_greater_than",
    "with_career_winning_percentage_greater_than",
    "with_career_num_sv_greater_than",
    "managers_with_career_w_greater_than"
  ]

  scope :active_is, -> (active_flag) { where(active: ActiveModel::Type::Boolean.new.cast(active_flag)) }
  scope :active, -> { where(active: true) }
  scope :non_active, -> { where(active: false) }
  scope :pitchers, -> { where(is_pitcher: true) }
  scope :non_pitchers, -> { where(is_pitcher: false) }
  scope :with_career_num_ab_greater_than, -> (tot_ab) { where("tot_ab_batter > ?", tot_ab.to_i).order("tot_ab_batter DESC NULLS LAST") }
  scope :with_career_num_ab_less_than, -> (tot_ab) { where("tot_ab_batter < ?", tot_ab.to_i).order("tot_ab_batter DESC NULLS LAST") }
  scope :with_career_num_ips_greater_than, -> (tot_ips) { where("tot_ipouts_pitcher > ?", tot_ips.to_i*3).order("tot_ipouts_pitcher DESC NULLS LAST") }
  scope :with_career_num_ips_less_than, -> (tot_ips) { where("tot_ipouts_pitcher < ?", tot_ips.to_i*3).order("tot_ipouts_pitcher DESC NULLS LAST") }
  scope :with_career_num_ipouts_greater_than, -> (tot_ipouts) { where("tot_ipouts_pitcher > ?", tot_ipouts.to_i).order("tot_ipouts_pitcher DESC NULLS LAST") }
  scope :with_career_num_ipouts_less_than, -> (tot_ipouts) { where("tot_ipouts_pitcher < ?", tot_ipouts.to_i).order("tot_ipouts_pitcher DESC NULLS LAST") }
  scope :with_career_num_sv_greater_than, -> (tot_sv) { where("tot_sv_pitcher > ?", tot_sv.to_i).order("tot_sv_pitcher DESC NULLS LAST") }
  scope :with_career_num_sv_less_than, -> (tot_sv) { where("tot_sv_pitcher < ?", tot_sv.to_i).order("tot_sv_pitcher DESC NULLS LAST") }
  scope :with_career_winning_percentage_greater_than, -> (win_percentage) { where("( cast(tot_w_pitcher as decimal)/(tot_w_pitcher + tot_l_pitcher) ) > ?", win_percentage.to_f).order("tot_w_pitcher DESC NULLS LAST") }
  scope :hall_of_famers, -> { where(is_hall_of_famer: true) }
  scope :all_stars, -> { where(is_all_star: true) }
  scope :managers_with_career_w_greater_than, -> (tot_w) { where(is_manager: true).where("tot_w_manager > ?", tot_w.to_i).order("tot_w_manager DESC NULLS LAST") }
  scope :top_managers, -> (lim) { where(is_manager: true).limit(lim).order("tot_w_manager DESC NULLS LAST") }
  scope :negro_league_hall_of_famers, -> { where(is_nlg_hall_of_famer: true) }

  def self.ransackable_scopes(auth_object = nil)
    PREBUILT_QUERIES.map{|q| q.to_sym}
  end

end
