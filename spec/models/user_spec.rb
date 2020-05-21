require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'crate' do
    context 'check user' do
      let!(:first_user)  { create(:user) }
      let!(:second_user) { create(:user) }

      it 'first user is admin' do
        user = first_user
        expect(user.admin).to eq(true)
      end

      it 'second user is not admin' do
        admin = first_user
        user = second_user
        expect(user.admin).to eq(false)
      end
    end

    context 'is valid' do
      it 'with valid attributes' do
        expect(create(:user)).to be_valid
      end
    end
    
    context 'is not valid' do
      it 'without a name' do
        user = User.new(name: nil)
        user.valid?
        expect(user.errors[:name]).to include("can't be blank")
      end
      
      it 'without an email' do
        user = User.new(email: nil)
        user.valid?
        expect(user.errors[:email]).to include("can't be blank")
      end

      it 'without a password' do
        user = User.new(password: nil)
        user.valid?
        expect(user.errors[:password]).to include("can't be blank")
      end
    end
  end
end
