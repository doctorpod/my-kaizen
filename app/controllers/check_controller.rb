class CheckController < ApplicationController
  skip_before_action :verify_authenticity_token

  # POST /checks
  def create
    item = Item.find(params[:item_id])
    item.add_check(params[:client_date])
    date = Date.parse(params[:client_date])
    render json: {
      item: {
        id: item.id,
        count: item.count_for(date),
        card: {
          id: item.card_id,
          scores: {
            today: format(item.card.score_today(date)),
            yesterday: format(item.card.score_yesterday(date)),
            recent_average: format(item.card.recent_average(date))
          }
        }
      }
    },
    status: :created
  end

  private

  def check_params
    # whitelist params
    params.permit(:item_id, :client_date)
  end

  def format(val)
    "%0.2f" % val.round(2)
  end
end
