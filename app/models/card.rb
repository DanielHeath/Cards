class Deck
  include MongoMapper::EmbeddedDocument
  
  key :description, String, :required => true
  
end