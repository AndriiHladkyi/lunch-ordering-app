class DashboardController < ApplicationController
  def index
    @date = Date.today
  end

  def by_day
    @date = params[:date].to_date
    @items = Item.where(date: @date)
    @categories = Category.all
  end
end
