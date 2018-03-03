class AddFlagsSumsAndTotalsToPlayers < ActiveRecord::Migration[5.1]
  def up
    # here we want to sum up all the totals that we search for and sort on to speed things
    add_column :players, :is_mlbp, :boolean, default: true, null: false, index: true
    add_column :players, :is_pitcher, :boolean, default: false, null: false, index: true
    add_column :players, :is_manager, :boolean, default: false, null: false, index: true
    add_column :players, :is_all_star, :boolean, default: false, null: false, index: true
    add_column :players, :is_hall_of_famer, :boolean, default: false, null: false, index: true
    add_column :players, :is_nlg_hall_of_famer, :boolean, default: false, null: false, index: true
    add_column :players, :tot_g_batter, :integer
    add_column :players, :tot_ab_batter, :integer
    add_column :players, :tot_r_batter, :integer
    add_column :players, :tot_h_batter, :integer
    add_column :players, :tot_hr_batter, :integer
    add_column :players, :tot_rbi_batter, :integer
    add_column :players, :tot_sb_batter, :integer
    add_column :players, :tot_bb_batter, :integer
    add_column :players, :tot_ibb_batter, :integer
    add_column :players, :tot_w_pitcher, :integer
    add_column :players, :tot_l_pitcher, :integer
    add_column :players, :tot_g_pitcher, :integer
    add_column :players, :tot_gs_pitcher, :integer
    add_column :players, :tot_cg_pitcher, :integer
    add_column :players, :tot_sho_pitcher, :integer
    add_column :players, :tot_sv_pitcher, :integer
    add_column :players, :tot_ipouts_pitcher, :integer
    add_column :players, :tot_er_pitcher, :integer
    add_column :players, :tot_so_pitcher, :integer
    add_column :players, :tot_g_manager, :integer
    add_column :players, :tot_w_manager, :integer
    add_column :players, :tot_l_manager, :integer
    Player.reset_column_information
    execute('
        UPDATE players
        SET is_mlbp = false
        WHERE ( (id NOT IN (SELECT player_id FROM batting_stats)) AND
                (id NOT IN (SELECT player_id FROM pitching_stats)) AND
                (id NOT IN (SELECT player_id FROM fielding_stats))
              );
      ')
    execute('
        UPDATE players
        SET is_pitcher = true
        WHERE ( id IN (SELECT player_id FROM pitching_stats) );
      ')
    execute('
        UPDATE players
        SET is_manager = true
        WHERE ( id IN (SELECT player_id FROM managers) );
      ')
    execute('
        UPDATE players
        SET is_all_star = true
        WHERE ( id IN (SELECT player_id FROM all_star_appearances) );
      ')

    execute('
        UPDATE players
        SET is_hall_of_famer = true
        WHERE ( id IN (SELECT player_id FROM hall_of_fame_appearances WHERE hall_of_fame_appearances.inducted IS TRUE)
              );
      ')
    execute('
        UPDATE players
        SET is_nlg_hall_of_famer = true
        WHERE ( id IN (SELECT player_id FROM hall_of_fame_appearances
                       WHERE hall_of_fame_appearances.inducted IS TRUE AND
                       hall_of_fame_appearances.voted_by = \'Negro League\'
                      )
              );
      ')
    execute('
        UPDATE players
        SET
             tot_g_batter = batting_totals.tot_g_batter,
             tot_ab_batter = batting_totals.tot_ab_batter,
             tot_r_batter = batting_totals.tot_r_batter,
             tot_h_batter = batting_totals.tot_h_batter,
             tot_hr_batter = batting_totals.tot_hr_batter,
             tot_rbi_batter = batting_totals.tot_rbi_batter,
             tot_sb_batter = batting_totals.tot_sb_batter,
             tot_bb_batter = batting_totals.tot_bb_batter,
             tot_ibb_batter = batting_totals.tot_ibb_batter
        FROM
        (
          SELECT player_id, SUM(num_g) AS tot_g_batter,
                            SUM(num_ab) AS tot_ab_batter,
                            SUM(num_r) AS tot_r_batter,
                            SUM(num_h) AS tot_h_batter,
                            SUM(num_hr) AS tot_hr_batter,
                            SUM(num_rbi) AS tot_rbi_batter,
                            SUM(num_sb) AS tot_sb_batter,
                            SUM(num_bb) AS tot_bb_batter,
                            SUM(num_ibb) AS tot_ibb_batter
          FROM batting_stats
          GROUP BY player_id
        ) batting_totals
        WHERE players.id = batting_totals.player_id;
      ')

    execute('
        UPDATE players
        SET
             tot_w_pitcher = pitching_totals.tot_w_pitcher,
             tot_l_pitcher = pitching_totals.tot_l_pitcher,
             tot_g_pitcher = pitching_totals.tot_g_pitcher,
             tot_gs_pitcher = pitching_totals.tot_gs_pitcher,
             tot_cg_pitcher = pitching_totals.tot_cg_pitcher,
             tot_sho_pitcher = pitching_totals.tot_sho_pitcher,
             tot_sv_pitcher = pitching_totals.tot_sv_pitcher,
             tot_ipouts_pitcher = pitching_totals.tot_ipouts_pitcher,
             tot_er_pitcher = pitching_totals.tot_er_pitcher,
             tot_so_pitcher = pitching_totals.tot_so_pitcher
        FROM
        (
            SELECT player_id, SUM(num_w) AS tot_w_pitcher,
                              SUM(num_l) AS tot_l_pitcher,
                              SUM(num_g) AS tot_g_pitcher,
                              SUM(num_gs) AS tot_gs_pitcher,
                              SUM(num_cg) AS tot_cg_pitcher,
                              SUM(num_sho) AS tot_sho_pitcher,
                              SUM(num_sv) AS tot_sv_pitcher,
                              SUM(num_ipouts) AS tot_ipouts_pitcher,
                              SUM(num_er) AS tot_er_pitcher,
                              SUM(num_so) AS tot_so_pitcher
            FROM pitching_stats
          GROUP BY player_id
        ) pitching_totals
        WHERE players.id = pitching_totals.player_id;
      ')

    execute('
        UPDATE players
        SET
             tot_w_manager = manager_totals.tot_w_manager,
             tot_l_manager = manager_totals.tot_l_manager,
             tot_g_manager = manager_totals.tot_g_manager
        FROM
        (
            SELECT player_id, SUM(num_w) AS tot_w_manager,
                              SUM(num_l) AS tot_l_manager,
                              SUM(num_g) AS tot_g_manager
            FROM managers
          GROUP BY player_id
        ) manager_totals
        WHERE players.id = manager_totals.player_id;
      ')
  end
  def down
    remove_column :players, :is_mlbp
    remove_column :players, :is_pitcher
    remove_column :players, :is_manager
    remove_column :players, :is_all_star
    remove_column :players, :is_hall_of_famer
    remove_column :players, :is_nlg_hall_of_famer
    remove_column :players, :tot_g_batter
    remove_column :players, :tot_ab_batter
    remove_column :players, :tot_r_batter
    remove_column :players, :tot_h_batter
    remove_column :players, :tot_hr_batter
    remove_column :players, :tot_rbi_batter
    remove_column :players, :tot_sb_batter
    remove_column :players, :tot_bb_batter
    remove_column :players, :tot_ibb_batter
    remove_column :players, :tot_w_pitcher
    remove_column :players, :tot_l_pitcher
    remove_column :players, :tot_g_pitcher
    remove_column :players, :tot_gs_pitcher
    remove_column :players, :tot_cg_pitcher
    remove_column :players, :tot_sho_pitcher
    remove_column :players, :tot_sv_pitcher
    remove_column :players, :tot_ipouts_pitcher
    remove_column :players, :tot_er_pitcher
    remove_column :players, :tot_so_pitcher
    remove_column :players, :tot_g_manager
    remove_column :players, :tot_w_manager
    remove_column :players, :tot_l_manager
  end
end
