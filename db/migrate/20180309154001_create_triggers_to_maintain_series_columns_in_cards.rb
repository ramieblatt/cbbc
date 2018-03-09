class CreateTriggersToMaintainSeriesColumnsInCards < ActiveRecord::Migration[5.1]
  def up
    execute('
      CREATE OR REPLACE FUNCTION set_card_series_index() RETURNS trigger
          LANGUAGE plpgsql
          AS $$
            BEGIN
              UPDATE cards
              SET series_index = subquery.ind
              FROM  (
                  SELECT id,
                         row_number() OVER (PARTITION BY card_type, player_id, edition_id ORDER BY id) AS ind
                  FROM   cards
                  GROUP  BY id
                  ) AS subquery
              WHERE cards.id = subquery.id;
              RETURN NEW;
            END;
          $$;

      CREATE OR REPLACE FUNCTION set_card_total_cards_in_series() RETURNS trigger
          LANGUAGE plpgsql
          AS $$
            BEGIN
              UPDATE cards
              SET total_cards_in_series = subquery.card_count
              FROM  (
                  SELECT card_type,
                         edition_id,
                         player_id,
                         count(*) AS card_count
                  FROM   cards
                  GROUP  BY card_type, edition_id, player_id
                  ) AS subquery
              WHERE cards.card_type = subquery.card_type AND cards.player_id = subquery.player_id AND cards.edition_id = subquery.edition_id;
              RETURN NEW;
            END;
          $$;

      DROP TRIGGER IF EXISTS card_series_index_update ON cards;
      CREATE TRIGGER card_series_index_update AFTER INSERT OR DELETE ON cards FOR EACH ROW EXECUTE PROCEDURE set_card_series_index();
      DROP TRIGGER IF EXISTS card_total_cards_in_series_update ON cards;
      CREATE TRIGGER card_total_cards_in_series_update AFTER INSERT OR DELETE ON cards FOR EACH ROW EXECUTE PROCEDURE set_card_total_cards_in_series();
    ')
  end
  def down
    execute('
      DROP TRIGGER IF EXISTS card_series_index_update ON cards;
      DROP FUNCTION IF EXISTS set_card_series_index();
      DROP TRIGGER IF EXISTS card_total_cards_in_series_update ON cards;
      DROP FUNCTION IF EXISTS set_card_total_cards_in_series();
    ')
  end
end
