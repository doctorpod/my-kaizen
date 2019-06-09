class CardsController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :verify_authenticity_token, except: :index

  # GET /cards/deck?client_date=dd/mm/yyyy
  # Called by Stimulus cards controller on page load and
  # at turn of midnight
  def deck
    @cards = Card.includes(:items)
    @client_date = Date.parse(params[:client_date])
    @counts = PeriodSummary.where(date: @client_date).inject({}) do |hash, summary|
      hash[summary.item_id] = summary.count
      hash
    end

    render layout: false
  end

  # GET /cards/new
  def new
    @card = Card.new
  end

  # POST /cards
  def create
    Card.create(card_params)
    redirect_to cards_url
  end

  # GET /cards/:id/edit
  def edit
    @card = Card.find(params[:id])
  end

  # PUT /cards/:id
  def update
    card = Card.find(params[:id])
    card.update(card_params)
    redirect_to cards_url
  end

  # DELETE /cards/:id
  def destroy
    card = Card.find(params[:id])
    card.destroy
    redirect_to cards_url
  end

  private

  def check_params
    # whitelist params
    params.permit(:client_date)
  end

  def card_params
    params.require(:card).permit(:title, :description)
  end
end
