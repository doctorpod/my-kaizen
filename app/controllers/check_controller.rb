class CheckController < ApplicationController
  include Secured
  skip_before_action :verify_authenticity_token

  # PUT /checks/increment
  def increment
    item = Item.find(params[:item_id])
    item.increment_check(params[:client_date], profile.id)
    render json: item_json(item, params[:client_date]), status: :created
  end

  # PUT /checks/decrement
  def decrement
    item = Item.find(params[:item_id])
    item.decrement_check(params[:client_date])
    render json: item_json(item, params[:client_date]), status: :created
  end

  private

  def check_params
    # whitelist params
    params.permit(:item_id, :client_date)
  end

  def item_json(item, client_date)
    date = Date.parse(client_date)
    {
      item: {
        id: item.id,
        count: item.count_for(date),
        card: {
          id: item.card_id,
          rewards: item.card.rewards(date),
          scores: {
            today: item.card.score_today(date),
            yesterday: item.card.score_yesterday(date),
            recent_average: item.card.recent_average(date)
          }
        }
      }
    }
  end
end
