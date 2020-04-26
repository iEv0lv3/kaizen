require 'rails_helper'

RSpec.describe 'As a User', elasticsearch: true do
  describe 'When I visit the home page page', :vcr do
    before :each do
      
      @user = User.create!(
        { email: 'user_1@turing.io',
          password: 'password',
          first_name: 'Luther',
          last_name: 'Van Draws',
          cohort: '1811',
          status: 1,
          user_name: 'Luther123' }
        )
        @user.confirm
        
      visit '/'

      expect(page).to have_content('Sign In')

      click_on 'Sign In'

      expect(current_path).to eq('/users/sign_in')

      fill_in :user_email, with: @user.email
      fill_in :user_password, with: @user.password

      click_on 'Log in'

      expect(current_path).to eq('/')

      click_on ':: Kaizen ::'

      expect(current_path).to eq('/')
    end

    it 'I can search' do
      within '#search-bar' do
        fill_in with: 'simplecov'
      end

      within '#search-button' do
        click_on 'search'
      end

      expect(current_path).to eq('/search')
    end

    it 'I can search and return both questions and answers with valid search terms' do
      within '#search-bar' do
        fill_in with: 'simplecov'
      end

      within '#search-button' do
        click_on 'search'
      end

      expect(current_path).to eq('/search')
      expect(page).to have_content('Search Results')

      # expect(first('#question-2').text).to_not be_empty
      # expect(last('#question-2').text).to_not be_empty
    end

    it 'I leave search bar blank I stay on welcome page with flash message' do
      within '#search-bar' do
        fill_in with: ''
      end

      within '#search-button' do
        click_on 'search'
      end

      expect(current_path).to eq('/')
      expect(page).to have_content('You must enter something to search.')
    end

    it 'if I search something not in the database I am prompted to improve search' do
      within '#search-bar' do
        fill_in with: 'simple cov'
      end

      within '#search-button' do
        click_on 'search'
      end

      expect(current_path).to eq('/search')
      expect(page).to have_content('Improve your query for better results.')
    end
  end
end
