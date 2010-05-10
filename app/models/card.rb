class Card
  include Mongoid::Document
  field :description
  embedded_in :deck, :inverse_of => :cards
end

