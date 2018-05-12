class PlayerImage < ApplicationRecord
  belongs_to :player, inverse_of: :player_images
  include ActiveModel::Serialization
end
