class Edition < ApplicationRecord
  has_many :cards, inverse_of: :edition, dependent: :destroy
  has_many :packs, inverse_of: :edition, dependent: :destroy

  validates_presence_of :number
  validates_uniqueness_of :number
  validates_presence_of :name
  validates_uniqueness_of :name

  scope :published, -> { where(is_published: true) }
  scope :unpublished, -> { where(is_published: false) }

  def self.next_edition_number
    Edition.count
  end

  def name_with_number
    "Edition #{number}: #{name}"
  end

  def create_cards(options)
    return false if is_published?
    options[:total_cards] ||= 1000
    cards.destroy_all
    Edition.connection.execute('
      INSERT INTO cards (player_id, edition_id, created_at, updated_at)
      (SELECT "players"."id" as player_id, ' + id.to_s + ', date(\''+Date.today.to_s+'\'), date(\''+Date.today.to_s+'\') FROM players ORDER BY RANDOM() LIMIT ' + options[:total_cards].to_s + ')
      ')
    return options[:total_cards]
  end

  def create_cards_from_players(options)
    return false if is_published?
    puts "!!!Edition#create_cards_from_players: options[\"q_json\"]: #{options["q_json"].inspect}"
    puts "!!!Edition#create_cards_from_players: options[\"average_num_cards\"]: #{options["average_num_cards"]}"
    players_ransack = Player.ransack(JSON.parse(options["q_json"])).result
    players_ransack_sql = players_ransack.to_sql
    players_sql = players_ransack_sql.gsub("SELECT \"players\".*", "SELECT \"players\".\"id\" AS player_id, #{id.to_s}, date(\'#{Date.today.to_s}\'), date(\'#{Date.today.to_s}\')")
    sql = '
    INSERT INTO cards (player_id, edition_id, created_at, updated_at) ('+players_sql+');
    '
    Edition.connection.execute(sql)
    # puts "!!!Edition#create_cards_from_players: Edition.connection.execute(#{sql})"
    total_cards = players_ransack.count
    average_num_cards = options["average_num_cards"].to_i
    players_ransack.pluck(:id).each do |player_id|
      rand(average_num_cards).times do |i|
        cards.create!({player_id: player_id, series_index: i+2})
        total_cards += 1
      end
    end
    sql = '
      UPDATE cards
      SET total_cards_in_series = subquery.card_count
      FROM  (
          SELECT edition_id,
                 player_id,
                 count(player_id) AS card_count
          FROM   cards
          GROUP  BY edition_id, player_id
          ) AS subquery
      WHERE cards.player_id = subquery.player_id AND cards.edition_id = subquery.edition_id;
      '
    Edition.connection.execute(sql)
    # puts "!!!Edition#create_cards_from_players: Edition.connection.execute(#{sql})"
    return total_cards
  end

  # def create_cards_from_players(options)
  #   return false if is_published?
  #   puts "!!!Edition#create_cards_from_players: options[\"q_json\"]: #{options["q_json"].inspect}"
  #   players_ransack_sql = Player.ransack(JSON.parse(options["q_json"])).result(distinct: true).to_sql
  #   players_sql = players_ransack_sql.gsub("SELECT DISTINCT \"players\".*", "SELECT \"players\".\"id\" AS player_id, #{id.to_s}, date(\'#{Date.today.to_s}\'), date(\'#{Date.today.to_s}\')")
  #   if (average_num_cards = options["average_num_cards"].to_i) > 1
  #     sql = '
  #     DO $$
  #     DECLARE
  #       i record;
  #     BEGIN
  #       FOR i IN 1..floor(random() * ('+average_num_cards.to_s+' + 1)) LOOP
  #         INSERT INTO cards (player_id, edition_id, created_at, updated_at) ('+players_sql+');
  #       END LOOP;
  #     END;
  #     $$;
  #     '
  #   else
  #     sql = '
  #     INSERT INTO cards (player_id, edition_id, created_at, updated_at) ('+players_sql+');
  #     '
  #   end
  #   Edition.connection.execute(sql)
  #   # puts "!!!Edition#create_cards_from_players: Edition.connection.execute(#{sql})"
  #   sql = '
  #     UPDATE cards
  #     SET series_index = subquery.ind,
  #         total_cards_in_series = subquery.card_count
  #     FROM  (
  #         SELECT edition_id,
  #                player_id,
  #                id,
  #                row_number() OVER(ORDER BY id) AS ind
  #                count(player_id) AS card_count
  #         FROM   cards
  #         GROUP  BY edition_id, player_id, id
  #         ORDER  BY id ASC
  #         ) AS subquery
  #     WHERE cards.player_id = subquery.player_id AND cards.edition_id = subquery.edition_id;
  #     '
  #   Edition.connection.execute(sql)
  #   # puts "!!!Edition#create_cards_from_players: Edition.connection.execute(#{sql})"
  #   return false
  # end

end
