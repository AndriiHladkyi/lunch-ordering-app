require 'rails_helper'
require_relative '../support/devise'

RSpec.describe DashboardController, type: :controller do
  describe 'Login as admin' do
    login_admin

    describe 'GET #index' do
      it 'returns a success response' do
        get :index
        expect(response).to be_successful
      end
    end
  end

  describe 'Login as user' do
    login_user

    describe 'GET #index' do
      it 'returns a success response' do
        get :index
        expect(response).to be_successful
      end
    end

    describe 'GET #index' do
      it 'returns a success response' do
        date = Date.today
        get :by_day, params: { date: date }
        expect(response).to be_successful
      end
    end
  end
end