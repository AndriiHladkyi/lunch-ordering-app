class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :authorize_admin, only: [:index, :create, :update, :destroy]

  def index
    @items = Item.order(date: :desc)
  end

  def show
  end

  def new
    @item = Item.new
    @categories = Category.all.map{|c| [c.name, c.id]}
  end

  def edit
  end

  def create
    item = Item.new(item_params)
    item.image = item_params[:image]
    item.date = Date.today

    respond_to do |format|
      if item.save
        format.html { redirect_to item, notice: 'Item was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    change_price = (@item.price - item_params[:price].to_i) != 0
    respond_to do |format|
      if @item.update(item_params)
        update_orders if change_price
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
    end
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:title, :price, :category_id, :date, :description, :image)
  end

  def update_orders
    @item.orders.each do |order|
      new_total_price = order.items.map(&:price).sum
      order.update(total_price: new_total_price)
    end
  end
end
