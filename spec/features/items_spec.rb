require 'rails_helper'

RSpec.feature 'Items', type: :feature do
  let(:admin) { create(:user) }
  
  describe 'login as admin' do
    before do
      visit "/"
      fill_in "Email", with: admin.email
      fill_in "Password", with: admin.password
      click_button "Log in"
    end

    it 'display items list' do
      click_on('Items')

      expect(page).to have_content 'Image'
      expect(page).to have_content 'Title'
      expect(page).to have_content 'Price'
      expect(page).to have_content 'Category'
      expect(page).to have_content 'Description'
    end

    it 'display a button for a new item' do
      click_on('Items')
  
      expect(page).to have_selector(:link_or_button, 'New item')
    end
  end
end