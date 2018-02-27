class Manager < ApplicationRecord
  belongs_to :player, inverse_of: :managers
end
