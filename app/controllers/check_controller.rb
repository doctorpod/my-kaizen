class CheckController < ApplicationController
  skip_before_action :verify_authenticity_token

  # POST /checks
  def create
    item = Item.find(params[:item_id])
    item.create_check
    render json: {
      card: {
        id: item.card_id,
        total: {
          today: item.card.total_today,
          yesterday: item.card.total_yesterday
        },
      },
      item_count: item.count_today
    },
    status: :created
  end

  private

  def check_params
    # whitelist params
    params.permit(:item_id)
  end
end