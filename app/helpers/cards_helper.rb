module CardsHelper
  def card_links_to_bbref(card)
    res = ""
    player = card.player
    if player.is_mlbp? or (!player.is_manager?)
      res << link_to("#{player.lahman_bbref_id}", "https://www.baseball-reference.com/#{player.is_mlbp? ? 'players/'+player.lahman_bbref_id.to_s[0] : 'nonmlbpa'}/#{player.lahman_bbref_id}.shtml", target: '_new')
    end
    if player.is_manager?
      if player.is_mlbp?
        res << raw(" | ")
      end
      res << link_to("#{player.lahman_bbref_id} (as mgr)", "https://www.baseball-reference.com/managers/#{player.lahman_bbref_id}.shtml", target: '_new_mgr')
    end
    return raw(res)
  end

  def canonical_card_link_to_bbref(card)
    player = card.player
    if card.card_type.index("manager")
      res = "https://www.baseball-reference.com/managers/#{player.lahman_bbref_id}.shtml"
    else
      res = "https://www.baseball-reference.com/#{player.is_mlbp? ? 'players/'+player.lahman_bbref_id.to_s[0] : 'nonmlbpa'}/#{player.lahman_bbref_id}.shtml"
    end
    return raw(res)
  end

end
