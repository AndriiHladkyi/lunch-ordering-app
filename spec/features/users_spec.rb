require 'rails_helper'

RSpec.feature 'Users', type: :feature do
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

    it 'display header' do
      expect(page).to have_content 'Categories'
      expect(page).to have_content 'Items'
      expect(page).to have_content 'Users'
      expect(page).to have_content 'Orders'
      expect(page).to have_content 'Edit profile'
      expect(page).to have_content 'Sign out'
    end

    it 'display users list' do
      click_on('Users')

      expect(page).to have_content 'Name'
      expect(page).to have_content 'Email'
      expect(page).to have_content 'Created at'
      expect(page).to have_content 'Admin?'
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

    it 'display header' do
      expect(page).to have_content 'Dashboard'
      expect(page).to have_content 'Your orders'
      expect(page).to have_content 'Edit profile'
      expect(page).to have_content 'Sign out'
    end
  end
end