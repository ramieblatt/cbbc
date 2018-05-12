desc "Scrape Player Images"

require 'nokogiri'
require 'open-uri'

task :scrape_all_player_images  => :environment do

  Player.where(has_images: false).find_in_batches do |batch|
    batch.each { |player| player.scrape_images }
  end

end
