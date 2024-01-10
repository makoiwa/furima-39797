class ItemsController < ApplicationController
  def index
    #@items = Item.order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def item_params
    params.require(:item).permit(:item, :explanation, :category_id, :condition_id, :delivery_cost_id, :prefectures_id, :shipment_day_id, :price, :image).merge(user_id: current_user.id)
  end
end
