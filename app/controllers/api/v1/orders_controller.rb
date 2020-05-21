class Api::V1::OrdersController < Api::ApplicationController
  before_action :set_items, only: [:create]

  def index
    date = Date.today
    orders = current_api_user.admin? ? Order.where(date: date) : Order.where(user_id: current_api_user.id)
    
    render json: orders, each_serializer: OrderSerializer, status: :ok
  end

  def create
    order = Order.new
    order.items = @items
    order.user_id = current_api_user.id

    if order.save
      render json: order, each_serializer: OrderSerializer, status: :ok
    else
      render json: order.errors, status: :unprocessable_entity
    end 
  end

  private

  def set_items
    @items ||= Item.where(id: params[:items_ids].split(','))
  end
end