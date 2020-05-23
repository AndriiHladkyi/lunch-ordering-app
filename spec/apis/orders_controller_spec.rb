require "rails_helper"

describe Api::V1::OrdersController, type: :controller do
  describe 'authenticate with token' do
    let(:create_users) { 
      @admin = create(:user) 
      @user = create(:user)
    }

    let(:authenticate_admin) { 
      create_users
      response = AuthenticateUser.call(@admin.email, @admin.password)
      { "Authorization" => "Bearer #{response.result}" } 
    }

    let(:authenticate_user) { 
      create_users
      response = AuthenticateUser.call(@user.email, @user.password)
      { "Authorization" => "Bearer #{response.result}" } 
    }

    describe 'GET #index' do
      it 'as admin' do
        request.headers.merge!(authenticate_admin)
        get :index
        expect(response).to be_successful
      end

      it 'as user' do
        request.headers.merge!(authenticate_user)
        get :index
        expect(response).to be_successful
      end
    end
  end

  describe 'without authenticate' do
    describe 'GET #index' do
      it 'as unregistered user' do
        get :index
        expect(response).to be_unauthorized
      end
    end
  end
end  