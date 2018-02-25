class Appearance < ApplicationRecord
  belongs_to :player, inverse_of: :appearances
end
