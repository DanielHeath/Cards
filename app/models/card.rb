class Card
  SUITS = ["Clubs", "Hearts", "Spades", "Diamonds"]
  CARD_VALUES = ["Ace", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Jack", "Queen", "King"]
  CARDS = ["Black Joker", "Red Joker"] + SUITS.map {|suit| CARD_VALUES.map {|cardval| "#{cardval} of #{suit}" } }.flatten
  
  include Mongoid::Document
  include Mongoid::Timestamps
  field :description
  embedded_in :deck, :inverse_of => :cards
  
end




