class CardSerializer < ActiveModel::Serializer

  # see https://docs.opensea.io/docs/2-adding-metadata

  # image
  # This is the image of the item.
  # external_url
  # This is the URL that the item will link to on OpenSea. It should be the URL of that individual item on your site.
  # description
  # A human readable description of the item.
  # name
  # Name of the item
  # attributes
  # These are the attributes of the items, which will show up on the OpenSea page for the item. You should include string attributes as strings (remember the quotes), and numeric properties as either floats or integers so that OpenSea can display them appropriately. You should also use underscore case (for example, max_power) for these properties to show up as human-readable strings on OpenSea.
  # background_color
  # Background color of the item on OpenSea. Must be a six-character hexadecimal without a pre-pended #.


  # and https://docs.rarebits.io/v1.0/docs/listing-your-assets
  # key              type          description                                           example
  # name             string        Name to display for the token                         "Red Robot #14"
  # image_url        string        URL for an image to use to represent the token        "https://www.robotgame.com/images/14.png"
  # home_url         string        URL of the token on your website,                     "https://www.robotgame.com/robots/14.html"
  #                                will be linked to on the asset's page                 "This is the amazing Robot #14, please buy me!"
  # description      string        Longer description to use for the token
  # tags             Array<String> List of tags for the asset                            ["red","rare","fire"]
  # properties       Array<Object> Properties to display with the asset.
  #                                Should be in this format:
  #                                [{"key":string, "value":<string or number>,
  #                                  "type": <"string","integer","number">}, ...]
  #                                                                                      [{"key": "generation", "value": 4, type: "integer"}, {"key": "cooldown", "value": "slow", type: "string"}]

  attributes :image, :external_url, :description, :name, :background_color, :image_url, :home_url, :tags, :properties

  def image # opensea asks for this
    image_url
  end

  def external_url # opensea asks for this
    scope.card_url(object, :subdomain => 'www')
  end

  def description
    "edition #{object.edition.number}: #{object.edition.name} ##{object.series_index} of #{object.total_cards_in_series}"
  end

  def name # opensea and rarebits ask for this
    "#{object.player.first_name} #{object.player.last_name}"
  end

  def background_color
    "c1f4ff"
  end

  def image_url # rarebits asks for this
    scope.player_image_main_url(object.player)
  end

  def home_url # rarebits asks for this
    external_url
  end

  def tags
    object.tags
  end

  def properties
    attributes_list.map{|h| {"key": h[:trait_type], "value": h[:value], "type": (h[:display_type] || "string")}}
  end

  # because attributes is a reserved name, need to use this form...
  def attributes(*args)
      hash = super
      hash[:attributes] = attributes_list
      hash
  end

  def attributes_list
    [
      {
          "trait_type": "card_type",
          "value": "#{object.card_type}"
      },
      {
          "trait_type": "player",
          "value": "#{object.player.given_name} #{object.player.last_name}"
      },
      {
          "trait_type": "edition",
          "value": "edition #{object.edition.number}: #{object.edition.name}"
      },
      {
          "trait_type": "serial_number",
          "value": object.series_index,
          "max_value": object.total_cards_in_series,
          "display_type": "number"
      },
      {
          "trait_type": "positions",
          "value": "#{object.player.fielding_stats.map{|fs| fs.position_code}.uniq.join(', ')}"
      },
      {
          "trait_type": "bats",
          "value": "#{object.player.bats}"
      },
      {
          "trait_type": "throws",
          "value": "#{object.player.throws}"
      },
      {
          "trait_type": "height",
          "value": "#{(object.player.height.to_i/12).floor}\' #{(object.player.height.to_i % 12)}\"}"
      },
      {
          "trait_type": "weight",
          "value": "#{object.player.weight} lbs"
      },
      {
          "trait_type": "birth_date",
          "value": "#{object.player.birthday}"
      },
      {
          "trait_type": "born_in",
          "value": "#{object.player.birth_city}, #{object.player.birth_state}, #{object.player.birth_country}"
      },
      {
          "trait_type": "debut",
          "value": "#{object.player.debut}"
      },
      {
          "trait_type": "bb_reference_ID",
          "value": "#{object.player.lahman_bbref_id}"
      },
      {
          "trait_type": "bb_reference_url",
          "value": "#{scope.canonical_card_link_to_bbref(object)}"
      }
    ]
  end

end
