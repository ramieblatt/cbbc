class BattingStat < ApplicationRecord
  belongs_to :player

  def team
    Team.where(year_id: year_id, team_code: team_code).first
  end
end
