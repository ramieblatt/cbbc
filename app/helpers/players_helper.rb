module PlayersHelper

  def player_links_to_bbref(player, sep="<br/>")
    res = ""
    if player.is_mlbp? or (!player.is_manager?)
      res << link_to("#{player.lahman_bbref_id}", "https://www.baseball-reference.com/#{player.is_mlbp? ? 'players/'+player.lahman_bbref_id.to_s[0] : 'nonmlbpa'}/#{player.lahman_bbref_id}.shtml", target: '_new')
    end
    if player.is_manager?
      if player.is_mlbp?
        res << sep
      end
      res << link_to("#{player.lahman_bbref_id} (as mgr)", "https://www.baseball-reference.com/managers/#{player.lahman_bbref_id}.shtml", target: '_new_mgr')
    end
    return raw(res)
  end

  def player_images(player, num=nil, sep="<br/>")
    res = ""
    PlayerImage.where(player_id: player.id).limit(num || 100).each do |player_image|
      res << "<img src='#{player_image.bbref_url}' alt='#{player.given_name} #{player.last_name}' width=50 height=75/>"
    end
    return raw(res)
  end

  def player_image_main_url(player)
    player_image = PlayerImage.where(player_id: player.id).first
    return raw("#{player_image.bbref_url}")
  end

  def select_card_type_from_search
    res = "player"
    if params["q"]
      if params["q"]["is_manager_eq"] == "true"
        res = "manager"
      elsif params["q"]["is_pitcher_eq"] == "true"
        res = "pitcher"
      end
    end
    return res
  end

end
