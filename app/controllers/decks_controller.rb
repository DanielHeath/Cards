class DecksController < ApplicationController

  # GET /decks/1
  # GET /decks/1.xml
  def show
    @deck = Deck.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @deck }
    end
  end

  # GET /decks/new
  # GET /decks/new.xml
  def new
    @deck = Deck.create
    redirect_to @deck
  end

  def draw
    @deck = Deck.find(params[:id])
    cards = @deck.draw_cards(params[:draw])
    redirect_to @deck, :flash => {:drawn => cards.map(&:description)}
  end

end
