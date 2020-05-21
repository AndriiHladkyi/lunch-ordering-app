require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'create' do
    it 'is valid with valid attributes' do
      expect(create(:category)).to be_valid
    end
    
    it 'is not valid without a name' do
      category = Category.new(name: nil)
      category.valid?
      expect(category.errors[:name]).to include("can't be blank")
    end
  end
end
