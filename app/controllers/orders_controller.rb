class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order
  before_action :set_instance

  def index
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      Payjp.api_key = ENV['PAYJP_SECRET_KEY']
      Payjp::Charge.create(
        amount: @item.item_price,      # 商品の値段
        card: order_params[:token],    # カードトークン
        currency: 'jpy'                 # 通貨の種類（日本円）
      )
      @order_address.save
      redirect_to root_path
    else
      render :index

    end
  end

  private

  def set_instance
    @item = Item.find(params[:item_id])
  end

  def set_order
    @item = Item.find(params[:item_id])
    redirect_to root_path if current_user.id != @item.user_id && @item.order.present?
    return unless current_user.id == @item.user_id

    redirect_to root_path
  end

  def order_params
    params.require(:order_address).permit(:postal_code, :prefecture_id, :city, :address, :building,
                                          :phone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end
end
