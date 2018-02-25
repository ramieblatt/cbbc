class AllStarAppearance < ApplicationRecord
  belongs_to :player, inverse_of: :all_star_appearances
end
