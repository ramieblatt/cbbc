class HallOfFameAppearance < ApplicationRecord
  belongs_to :player, inverse_of: :hall_of_fame_appearances
end
