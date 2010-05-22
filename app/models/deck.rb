class Deck
  include Mongoid::Document
  include Mongoid::Timestamps
  embeds_many :cards
  embeds_many :activities do
    def by_date
      @target.sort do |a, b|
        b.updated_at <=> a.updated_at
      end
    end
  end
  
  def draw_cards(params)
    self.activities.build(:description => "Drawing #{params[:number].to_i} cards for '#{params[:reason]}'...")
    params[:number].to_i.times do
      draw_card(params[:reason])
    end
    save!
  end
  
  
  def draw_card(reason)
    reshuffle_deck if all_drawn?
    card = available_cards.pop
    self.cards.build(:description => card)
    self.activities.build(:description => Activity.make_draw_description(card, reason))
  end

  private

  def reshuffle_deck
    self.cards = []
    @available_cards = nil
    self.activities.build(:description => "Reshuffling the deck.")
    self.save
  end
  
  def available_cards
    @available_cards ||= get_available_cards
  end

  def get_available_cards
    res = (Card::CARDS - self.cards.map(&:description)).shuffle
  end
  
  def all_drawn?
    available_cards.empty?
  end
  
end
