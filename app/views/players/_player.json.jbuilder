json.extract! player, :first_name, :last_name, :given_name, :birthday, :birth_country, :birth_state, :birth_city, :death, :death_country, :death_state, :death_city, :weight, :height, :bats, :throws, :debut, :final_game, :lahman_player_id
json.url player_url(player, format: :json)
