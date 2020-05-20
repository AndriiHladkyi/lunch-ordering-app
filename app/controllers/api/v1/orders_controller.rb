class Api::V1::OrdersController < Api::ApplicationController
  before_action :set_items, only: [:create]

  def index
    date = Date.today
    orders = current_api_user.admin? ? Order.where(date: date) : Order.where(user_id: current_api_user.id)
    
    render json: orders, each_serializer: OrderSerializer, status: :ok
  end

  def create
    if check_items
      order = Order.new
      order.items = @items
      order.user_id = current_api_user.id
      order.total_price = @items.map(&:price).sum
      order.date = Date.today

      if order.save
        render json: order, each_serializer: OrderSerializer, status: :ok
      else
        render json: item.errors, status: :unprocessable_entity
      end 
    else
      render json: { errors: "Only one item from one category!" }.to_json, status: :unprocessable_entity
    end
  end

  private

  def set_items
    @items ||= Item.where(id: params[:items_ids].split(','))
  end

  def check_items
    categories_ids = Category.all.map(&:id)
    items_ids = @items.map(&:category_id).map(&:to_i).sort
    items_ids == categories_ids
  end
end