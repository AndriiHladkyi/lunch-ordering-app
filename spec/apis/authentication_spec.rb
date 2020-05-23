require "rails_helper"

describe Api::V1::AuthenticationController, type: :api do
  describe 'give a token' do
    let(:user) { create(:user) }

    describe 'POST # authenticate' do
      it 'with valid params' do
        post '/api/v1/authenticate', { email: user.email, password: user.password }
        expect(last_response).to be_successful
      end

      it "with invalid params" do
        post '/api/v1/authenticate', { email: user.email, password: nil }
        expect(last_response).to be_unauthorized
      end
    end
  end
end  