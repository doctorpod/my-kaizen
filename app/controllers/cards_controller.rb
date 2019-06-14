class CardsController < ApplicationController
  include Secured
  skip_before_action :verify_authenticity_token, only: :deck

  # GET /cards/deck?client_date=dd/mm/yyyy
  # Called by Stimulus cards controller on page load and
  # at turn of midnight
  def deck
    @cards = profile.cards.includes(:items)
    @client_date = Date.parse(params[:client_date])
    @counts = profile.period_summaries.where(date: @client_date).inject({}) do |hash, summary|
      hash[summary.item_id] = summary.count
      hash
    end

    render layout: false
  end

  # GET /cards/new
  def new
    @card = profile.cards.new
  end

  # POST /cards
  def create
    profile.cards.create(card_params)
    redirect_to cards_url
  end

  # GET /cards/:id/edit
  def edit
    @card = profile.cards.find(params[:id])
  end

  # PUT /cards/:id
  def update
    card = profile.cards.find(params[:id])
    card.update(card_params)
    redirect_to cards_url
  end

  # DELETE /cards/:id
  def destroy
    card = profile.cards.find(params[:id])
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
