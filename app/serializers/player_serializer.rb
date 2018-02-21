class PlayerSerializer < ActiveModel::Serializer
  attributes :first_name, :last_name, :given_name, :birthday, :birth_country, :birth_state, :birth_city, :death, :death_country, :death_state, :death_city, :weight, :height, :bats, :throws, :debut, :final_game, :lahman_player_id, :url
  include Rails.application.routes.url_helpers

  def url
    player_url(object, format: :json, host: ENV['EXTERNAL_HOST'] || 'localhost:3000',
  protocol: ENV['EXTERNAL_HOST_PROTOCOL'] || 'http')
  end
end
