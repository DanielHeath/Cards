class Activity
  include Mongoid::Document
  include Mongoid::Timestamps
  field :description
  embedded_in :deck, :inverse_of => :activities
  
  def self.make_draw_description(card, reason)
    "Drew the #{card} for '#{reason}'"
  end
  
  def describe
    "#{DateTime.now.to_formatted_s(:short)}: #{description}"
  end
end

