desc "Scrape Player Images"

require 'nokogiri'
require 'open-uri'

task :scrape_player_images  => :environment do

  Player.non_active.non_pitchers.with_career_num_ab_greater_than(5000).find_in_batches do |batch|
    batch.each { |player| player.scrape_images }
  end
  Player.non_active.pitchers.with_career_num_ips_greater_than(1800).with_career_winning_percentage_greater_than(0.52).find_in_batches do |batch|
    batch.each { |player| player.scrape_images }
  end
  Player.non_active.pitchers.with_career_num_sv_greater_than(184).find_in_batches do |batch|
    batch.each { |player| player.scrape_images }
  end
  Player.non_active.non_pitchers.with_career_num_ab_less_than(5000).hall_of_famers.find_in_batches do |batch|
    batch.each { |player| player.scrape_images }
  end
  Player.active.all_stars.find_in_batches do |batch|
    batch.each { |player| player.scrape_images }
  end
  Player.negro_league_hall_of_famers.find_in_batches do |batch|
    batch.each { |player| player.scrape_images }
  end
  Player.managers_with_career_w_greater_than(500).find_in_batches do |batch|
    batch.each { |player| player.scrape_images }
  end

end
