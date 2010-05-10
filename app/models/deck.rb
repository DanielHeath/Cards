class Deck
  include Mongoid::Document
  field :name
  embeds_many :cards
end
