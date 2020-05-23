require "rails_helper"

describe Api::V1::ItemsController, type: :controller do
  describe 'authenticate with token' do
    let(:user)         { create(:user) }
    let(:authenticate) { 
      response = AuthenticateUser.call(user.email, user.password)
      { "Authorization" => "Bearer #{response.result}" } 
    }

    describe 'GET #index' do
      it 'with valid token' do
        request.headers.merge!(authenticate)
        get :index
        expect(response).to be_successful
      end
    end
  end
end  