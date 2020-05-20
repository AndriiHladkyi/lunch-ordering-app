class Api::V1::ItemsController < Api::ApplicationController
  def index
    date = Date.today
    items = Item.where(date: date)
    
    render json: items, each_serializer: ItemSerializer, status: :ok
  end
end