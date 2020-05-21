require 'rails_helper'

RSpec.describe Item, type: :model do
  before(:example) do
    @category = create(:category)
  end

  describe 'create' do
    it 'is valid with valid attributes' do
      item = create(:item, category_id: @category.id)
      expect(item).to be_valid
    end
    
    it 'is not valid without a title' do
      item = Item.new(title: nil)
      item.valid?
      expect(item.errors[:title]).to include("can't be blank")
    end
    
    it 'is not valid without a price' do
      item = Item.new(price: nil)
      item.valid?
      expect(item.errors[:price]).to include("can't be blank")
    end
    
    it 'is not valid without a date' do
      item = Item.new(date: nil)
      item.valid?
      expect(item.errors[:date]).to include("can't be blank")
    end
    
    it 'is not valid without a category_id' do
      item = Item.new(category_id: nil)
      item.valid?
      expect(item.errors[:category_id]).to include("can't be blank")
    end
  end
end
