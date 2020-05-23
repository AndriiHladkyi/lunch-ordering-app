require 'rails_helper'

RSpec.feature 'Dashboard', type: :feature do
  let(:create_users) { 
    @admin = create(:user)
    @user = create(:user) 
  }
  
  describe 'login as user' do
    before do
      create_users
      visit "/"
      fill_in "Email", with: @user.email
      fill_in "Password", with: @user.password
      click_button "Log in"
    end

    it 'display last week' do
      click_on('Dashboard')
      today = Date.today
      last_day = today-6

      expect(page).to have_content today
      expect(page).to have_content last_day
      expect(page).to have_content today.strftime('%A')
      expect(page).to have_content last_day.strftime('%A')
      expect(page).to have_selector(:link_or_button, 'Select')
    end

    it 'show error message if there is no dishes' do
      today = Date.today
      visit "/dashboard/by_day/#{today}"

      expect(page).to have_content 'There is no dishes'
      expect(page).to have_selector(:link_or_button, 'Back')
    end
  end
end