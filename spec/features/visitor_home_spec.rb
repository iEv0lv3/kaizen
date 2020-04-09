require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'when I visit the home page' do
    it 'has a nav bar with different links on it' do
      visit root_path

      within '.nav' do
        expect(page).to have_content('Turing :: SO')
        expect(page).to have_content('Register')
        expect(page).to have_content('Forums')
        expect(page).to have_content('Ask a Question')
      end
    end

    it 'can click on the home link and be taken back to the root page' do
      visit root_path

      within '.nav' do
        click_on 'Turing :: SO'
      end

      expect(current_path).to eq(root_path)
    end

    it 'can register for an account' do
      visit root_path

      within '.nav' do
        click_on 'Register'
      end

      expect(current_path).to eq(new_user_registration_path)

      within '.new_user' do
        fill_in 'Email', with: 'email@example.com'
        fill_in 'Password', with: 'newpass'
        fill_in 'Password confirmation', with: 'newpass'

        click_on 'Sign up'
      end

      expect(current_path).to eq(root_path)
      expect(page).to have_content('A message with a confirmation link has been sent to your email address. Please follow the link to activate your account.')
    end
  end
end
