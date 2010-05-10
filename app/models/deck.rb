class Deck
  include MongoMapper::Document
  
  key :name, String, :required => true
  many :cards
end