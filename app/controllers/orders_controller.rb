class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :destroy]
  before_action :current_user?, only: [:show, :destroy]
  before_action :authorize_admin, only: [:by_day]

  def index
    @orders = current_user.admin? ? Order.all : Order.where(user_id: current_user.id)
  end

  def show
  end

  def new
    @order = Order.new
  end

  def create
    items = Item.where(id: order_params)
    order = Order.new
    order.items = items
    order.user_id = current_user.id

    respond_to do |format|
      if order.save
        format.html { redirect_to order, notice: 'Order was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
    end
  end

  def by_day
    @orders = Order.where(date: params[:date].to_date)
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(new_params)
  end

  def new_params
    Category.all.map{|c| "category_#{c.id}"}
  end

  def current_user?
    redirect_to root_path, status: 401 unless (current_user.id == @order.user_id)
  end
end
