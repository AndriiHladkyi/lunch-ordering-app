require 'rails_helper'
require_relative '../support/devise'

RSpec.describe UsersController, type: :controller do
  describe 'Login' do
    describe 'as admin' do
      login_admin

      describe 'GET #index' do
        it 'returns a success response' do
          get :index
          expect(response).to be_successful
        end
      end
    end

    describe 'as user' do
      login_user

      describe 'GET #index' do
        it 'returns a unauthorized response' do
          get :index
          expect(response).to be_unauthorized
        end
      end
    end
  end
end