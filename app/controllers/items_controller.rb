class ItemsController < ApplicationController
  # GET /items/new
  def new
    card = Card.find(params[:card_id])
    @item = card.items.new
  end

  # POST /items
  def create
    Item.create(item_params)
    redirect_to controller: :home, action: :index
  end

  # GET /items/:id/edit
  def edit
    @item = Item.find(params[:id])
  end

  # PUT /items/:id
  def update
    item = Item.find(params[:id])
    item.update(item_params)
    redirect_to controller: :home, action: :index
  end

  # DELETE /items/:id
  def destroy
    item = Item.find(params[:id])
    item.destroy
    redirect_to controller: :home, action: :index
  end

  private

  def item_params
    params.require(:item).permit(:title, :description, :score, :max, :card_id)
  end
end
