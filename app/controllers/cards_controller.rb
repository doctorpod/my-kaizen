class CardsController < ApplicationController
  skip_before_action :verify_authenticity_token

  # GET /cards/?client_date=dd/mm/yyyy
  # Called by Stimulus cards controller on page load and
  # at turn of midnight
  def index
    @cards = Card.includes(:items).all
    @client_date = Date.parse(params[:client_date])
    render layout: false
  end

  private

  def check_params
    # whitelist params
    params.permit(:client_date)
  end
end
