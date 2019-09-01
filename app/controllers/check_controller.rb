class CheckController < ApplicationController
  include Secured
  skip_before_action :verify_authenticity_token

  # PUT /checks/increment
  def increment
    item.increment_check(params[:client_date], profile.id)
    render_json(item, params[:client_date])
  end

  # PUT /checks/decrement
  def decrement
    item.decrement_check(params[:client_date])
    render_json(item, params[:client_date])
  end

  private

  def item 
    @item ||= Item.find(params[:item_id])
  end

  def render_json(item, client_date)
    render json: ItemStatsService.item(item, Date.parse(client_date)), status: :created
  end

  def check_params
    # whitelist params
    params.permit(:item_id, :client_date)
  end
end
