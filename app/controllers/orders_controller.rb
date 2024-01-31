class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :set_item, only: [:index, :create]
  
  def index
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @user = @item.user
    check_product_user
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params.merge(user_id: current_user.id, item_id: params[:item_id]))
    if @order_address.valid? 
      pay_item
      @order_address.save
      return redirect_to root_path
    else
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
      render 'orders/index', status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def check_product_user
    if current_user.id == @item.user.id
      redirect_to root_path
    elsif @item.order.present?
      redirect_to root_path
    end
  end

  def order_params
    params.require(:order_address).permit(:post_code, :prefectures_id, :city, :street_address, :building, :phone_number).merge(token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,  # 商品の値段
      card: order_params[:token],    # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end
end