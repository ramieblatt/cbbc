class Edition < ApplicationRecord
  has_many :cards, inverse_of: :edition, dependent: :destroy

  validates_presence_of :number
  validates_uniqueness_of :number
  validates_presence_of :name
  validates_uniqueness_of :name

  scope :published, -> { where(is_published: true) }
  scope :unpublished, -> { where(is_published: false) }

  def self.next_edition_number
    Edition.count
  end

  def self.select_options(current_user=nil)
    if current_user and current_user.is_admin
      Edition.all
    else
      Edition.published
    end
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
    card_count_start = cards.count
    puts "!!!Edition#create_cards_from_players: options[\"q_json\"]: #{options["q_json"].inspect}"
    players_ransack_sql = Player.ransack(JSON.parse(options["q_json"])).result(distinct: true).to_sql
    card_type = options["card_type"] || 'player'
    average_num_cards = options["average_num_cards"].to_i
    # if (average_num_cards) > 1
      players_sql = players_ransack_sql.gsub("SELECT DISTINCT \"players\".*", "SELECT \"players\".\"id\" AS player_id")
      num_cards_random_variation = options["num_cards_random_variation"].to_f
      integral_card_variation = num_cards_random_variation*average_num_cards.to_i
      sql = "
      DO $$
      DECLARE
        player_row record;
        i int;
      BEGIN
        ALTER TABLE cards DISABLE TRIGGER card_series_index_update;
        ALTER TABLE cards DISABLE TRIGGER card_total_cards_in_series_update;

        FOR player_row IN (#{players_sql}) LOOP
          FOR i IN 1..ceil(random()*2.0*#{integral_card_variation} - #{integral_card_variation} + #{average_num_cards}) LOOP
            INSERT INTO cards (player_id, edition_id, created_at, updated_at, card_type) VALUES (player_row.player_id, #{id}, date(\'#{Date.today}\'), date(\'#{Date.today}\'), \'#{card_type}\');
          END LOOP;
        END LOOP;

        ALTER TABLE cards ENABLE TRIGGER card_series_index_update;
        ALTER TABLE cards ENABLE TRIGGER card_total_cards_in_series_update;

        INSERT INTO cards (player_id, edition_id, created_at, updated_at, card_type) VALUES (0, 0, date(\'#{Date.today}\'), date(\'#{Date.today}\'), 'remove');
        DELETE FROM cards WHERE card_type='remove';
      END;
      $$;
      "
    # else
    #   players_sql = players_ransack_sql.gsub("SELECT DISTINCT \"players\".*", "SELECT \"players\".\"id\" AS player_id, #{id.to_s}, date(\'#{Date.today.to_s}\'), date(\'#{Date.today.to_s}\'), '#{card_type}'")
    #   sql = "
    #   ALTER TABLE cards DISABLE TRIGGER card_series_index_update;
    #   ALTER TABLE cards DISABLE TRIGGER card_total_cards_in_series_update;

    #   INSERT INTO cards (player_id, edition_id, created_at, updated_at, card_type) (#{players_sql});

    #   ALTER TABLE cards ENABLE TRIGGER card_series_index_update;
    #   ALTER TABLE cards ENABLE TRIGGER card_total_cards_in_series_update;

    #   INSERT INTO cards (player_id, edition_id, created_at, updated_at, card_type) VALUES (0, 0, date(\'#{Date.today}\'), date(\'#{Date.today}\'), 'remove');
    #   DELETE FROM cards WHERE card_type='remove';
    #   "
    # end
    Edition.connection.execute(sql)
    # puts "!!!Edition#create_cards_from_players: Edition.connection.execute(#{sql})"
    card_count_end = self.reload.cards.count
    return (card_count_end - card_count_start)
  end
  # def create_cards_from_players(options)
  #   return false if is_published?
  #   puts "!!!Edition#create_cards_from_players: options[\"q_json\"]: #{options["q_json"].inspect}"
  #   puts "!!!Edition#create_cards_from_players: options[\"average_num_cards\"]: #{options["average_num_cards"]}"
  #   players_ransack = Player.ransack(JSON.parse(options["q_json"])).result
  #   players_ransack_sql = players_ransack.to_sql
  #   players_sql = players_ransack_sql.gsub("SELECT \"players\".*", "SELECT \"players\".\"id\" AS player_id, #{id.to_s}, date(\'#{Date.today.to_s}\'), date(\'#{Date.today.to_s}\')")
  #   sql = '
  #   INSERT INTO cards (player_id, edition_id, created_at, updated_at) ('+players_sql+');
  #   '
  #   Edition.connection.execute(sql)
  #   # puts "!!!Edition#create_cards_from_players: Edition.connection.execute(#{sql})"
  #   total_cards = players_ransack.count
  #   average_num_cards = options["average_num_cards"].to_i
  #   players_ransack.pluck(:id).each do |player_id|
  #     rand(average_num_cards).times do |i|
  #       cards.create!({player_id: player_id, series_index: i+2})
  #       total_cards += 1
  #     end
  #   end
  #   sql = '
  #     UPDATE cards
  #     SET total_cards_in_series = subquery.card_count
  #     FROM  (
  #         SELECT edition_id,
  #                player_id,
  #                count(player_id) AS card_count
  #         FROM   cards
  #         GROUP  BY edition_id, player_id
  #         ) AS subquery
  #     WHERE cards.player_id = subquery.player_id AND cards.edition_id = subquery.edition_id;
  #     '
  #   Edition.connection.execute(sql)
  #   # puts "!!!Edition#create_cards_from_players: Edition.connection.execute(#{sql})"
  #   return total_cards
  # end

  def remove_all_cards!
    if is_published != true
      sql = "
        ALTER TABLE cards DISABLE TRIGGER card_series_index_update;
        ALTER TABLE cards DISABLE TRIGGER card_total_cards_in_series_update;
      "
      Edition.connection.execute(sql)
      Card.where(edition_id: id).delete_all
      sql = "
        ALTER TABLE cards ENABLE TRIGGER card_series_index_update;
        ALTER TABLE cards ENABLE TRIGGER card_total_cards_in_series_update;
      "
      Edition.connection.execute(sql)
    end
  end

end
