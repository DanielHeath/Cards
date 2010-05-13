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
    res = []
    res << activity("Drawing #{params[:number].to_i} cards for '#{params[:reason]}'...")
    params[:number].to_i.times do
      if available_cards.length == 0 then
        res << activity("Reshuffling as the deck is now empty!")
        self.cards.each {|c| c.destroy }
        reload_available_cards
        raise "Error reshuffling the deck" if available_cards.length == 0
      end
      card = available_cards.pop
      self.cards.build(:description => card)
      res << activity(Activity.make_draw_description(card, params[:reason]))
    end
    save!
    res
  end
  
  def activity(desc)
    self.activities.build(:description => desc)
  end
  
  def available_cards
    puts self.cards.inspect unless @available_cards
    @available_cards ||= (Card::CARDS - self.cards.map(&:description)).shuffle
  end
  
  def reload_available_cards
    @available_cards = nil
  end
  
end
