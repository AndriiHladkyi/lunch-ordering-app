require 'rails_helper'

RSpec.feature 'Orders', type: :feature do
  let(:create_users) { 
    @admin = create(:user)
    @user = create(:user) 
  }
  
  describe 'login as admin' do
    before do
      create_users
      visit "/"
      fill_in "Email", with: @admin.email
      fill_in "Password", with: @admin.password
      click_button "Log in"
    end

    it 'display last week' do
      click_on('Orders')
      today = Date.today
      last_day = today-6

      expect(page).to have_content today
      expect(page).to have_content last_day
      expect(page).to have_content today.strftime('%A')
      expect(page).to have_content last_day.strftime('%A')
      expect(page).to have_selector(:link_or_button, 'Select')
    end

    it 'show all today orders' do
      today = Date.today
      visit "/orders/by_day/#{today}"

      expect(page).to have_content 'Image'
      expect(page).to have_content 'Title'
      expect(page).to have_content 'Price'
      expect(page).to have_content 'Category'
      expect(page).to have_content 'Description'
      expect(page).to have_content 'Order cost'
      expect(page).to have_content 'Dishes total cost of the day is'
    end
  end

  describe 'login as user' do
    before do
      create_users
      visit "/"
      fill_in "Email", with: @user.email
      fill_in "Password", with: @user.password
      click_button "Log in"
    end

    it 'display your orders' do
      click_on('Your orders')

      expect(page).to have_content 'Image'
      expect(page).to have_content 'Title'
      expect(page).to have_content 'Price'
      expect(page).to have_content 'Category'
      expect(page).to have_content 'Description'
      expect(page).to have_content 'Total price'
      expect(page).to have_selector(:link_or_button, 'New order')
    end
  end
end