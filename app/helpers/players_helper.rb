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
