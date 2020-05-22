require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'create' do
    before(:example) do
      @admin = create(:user)
      @user = create(:user)
      category1 = create(:category)
      category2 = create(:category)
      category3 = create(:category)
      @item1 = create(:item, category_id: category1.id)
      @item2 = create(:item, category_id: category2.id)
      @item3 = create(:item, category_id: category3.id)
      @item4 = create(:item, category_id: category1.id)
    end

    let!(:order)       { Order.new(user_id: @user.id) }
    let!(:total_price) { order.items.map(&:price).sum }

    context 'is valid' do
      it 'with 3 items from 3 categories' do
        order.items = [@item1, @item2, @item3]
        order.total_price = total_price
        order.save
        expect(order).to be_valid
      end
    end

    context 'is not valid' do
      it 'with 3 items from 2 categories' do
        order.items = [@item1, @item2, @item4]
        order.total_price = total_price
        order.save
        expect(order).not_to be_valid
      end

      it 'with 4 items from 3 categories' do
        order.items = [@item1, @item2, @item3, @item4]
        order.total_price = total_price
        order.save
        expect(order).not_to be_valid
      end

      it 'with 2 items from 2 categories' do
        order.items = [@item1, @item2]
        order.total_price = total_price
        order.save
        expect(order).not_to be_valid
      end
    end
  end
end
