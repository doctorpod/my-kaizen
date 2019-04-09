class CheckController < ApplicationController
  skip_before_action :verify_authenticity_token

  # POST /checks
  def create
    check = Check.create!(check_params)
    render json: {
      card_id: check.item.card_id,
      card_total: check.item.card.total,
      item_count: check.item.checks.count
    },
    status: :created
  end

  private

  def check_params
    # whitelist params
    params.permit(:item_id)
  end
end
