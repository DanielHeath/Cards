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
    available_cards = (Card::CARDS - self.cards.map(&:description)).shuffle
    raise "Too many cards requested!" if params[:number].to_i > available_cards.length
    
    res = []
    res << self.activities.build(:description => "Drawing #{params[:number].to_i} cards for '#{params[:reason]}'...")
    params[:number].to_i.times do
      card = available_cards.pop
      self.cards.build(:description => card)
      res << self.activities.build(:description => Activity.make_draw_description(card, params[:reason]))
    end
    save!
    res
  end
  
end
