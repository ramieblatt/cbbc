class Card < ApplicationRecord
  belongs_to :player, inverse_of: :cards
  belongs_to :edition, inverse_of: :cards
  has_many :player_images, through: :player
  include ActiveModel::Serialization
  paginates_per 100
  CARD_TYPES = ["player", "pitcher", "manager"]
  AVERAGE_NUMBERS_PER_PLAYER = [1, 10, 100]
  PER_PLAYER_RANDOM_VARIATION = {none: 0.0, tenth: 0.1, fifth: 0.2, quarter:0.25, third: 0.3333, two_fifths: 0.4, half: 0.5, three_fifths: 0.6, two_thirds: 0.6667, three_quarters: 0.75, four_fifths: 0.8, nine_tenths: 0.9, full: 1.0}
  PREBUILT_QUERIES = [
    "player_with_career_num_ab_greater_than",
    "player_with_career_num_ab_less_than",
    "player_with_career_num_ips_greater_than",
    "player_with_career_winning_percentage_greater_than",
    "player_with_career_num_sv_greater_than",
    "player_managers_with_career_w_greater_than"
  ]

  scope :player_with_career_num_ab_greater_than, -> (tot_ab) { joins(:player).where("players.tot_ab_batter > ?", tot_ab.to_i).order("players.tot_ab_batter DESC NULLS LAST") }
  scope :player_with_career_num_ab_less_than, -> (tot_ab) { joins(:player).where("players.tot_ab_batter < ?", tot_ab.to_i).order("players.tot_ab_batter DESC NULLS LAST") }
  scope :player_with_career_num_ips_greater_than, -> (tot_ips) { joins(:player).where("players.tot_ipouts_pitcher > ?", tot_ips.to_i*3).order("players.tot_ipouts_pitcher DESC NULLS LAST") }
  scope :player_with_career_num_ips_less_than, -> (tot_ips) { joins(:player).where("players.tot_ipouts_pitcher < ?", tot_ips.to_i*3).order("players.tot_ipouts_pitcher DESC NULLS LAST") }
  scope :player_with_career_num_ipouts_greater_than, -> (tot_ipouts) { joins(:player).where("players.tot_ipouts_pitcher > ?", tot_ipouts.to_i).order("players.tot_ipouts_pitcher DESC NULLS LAST") }
  scope :player_with_career_num_ipouts_less_than, -> (tot_ipouts) { joins(:player).where("players.tot_ipouts_pitcher < ?", tot_ipouts.to_i).order("players.tot_ipouts_pitcher DESC NULLS LAST") }
  scope :player_with_career_num_sv_greater_than, -> (tot_sv) { joins(:player).where("players.tot_sv_pitcher > ?", tot_sv.to_i).order("players.tot_sv_pitcher DESC NULLS LAST") }
  scope :player_with_career_num_sv_less_than, -> (tot_sv) { joins(:player).where("players.tot_sv_pitcher < ?", tot_sv.to_i).order("players.tot_sv_pitcher DESC NULLS LAST") }
  scope :player_with_career_winning_percentage_greater_than, -> (win_percentage) { joins(:player).where("( cast(players.tot_w_pitcher as decimal)/(players.tot_w_pitcher + players.tot_l_pitcher) ) > ?", win_percentage.to_f).order("players.tot_w_pitcher DESC NULLS LAST") }
  scope :player_managers_with_career_w_greater_than, -> (tot_w) { joins(:player).where("players.is_manager IS TRUE").where("players.tot_w_manager > ?", tot_w.to_i).order("players.tot_w_manager DESC NULLS LAST") }

  def self.ransackable_scopes(auth_object = nil)
    PREBUILT_QUERIES.map{|q| q.to_sym}
  end

  def tags
    res = []
    res << card_type
    res << 'manager' if player.is_manager?
    res << 'pitcher' if player.is_pitcher?
    res << 'hall of famer' if player.is_hall_of_famer?
    res << 'negro leage hall of famer' if player.is_nlg_hall_of_famer?
    res << 'all star' if player.is_all_star?
    res.compact.uniq
  end

end
