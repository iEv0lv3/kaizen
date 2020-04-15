require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'when I visit the home page' do
    it 'has a nav bar with different links on it' do
      visit root_path

      within '.nav' do
        expect(page).to have_content(':: Kaizen ::')
        expect(page).to have_content('Register')
        expect(page).to have_content('Forums')
        expect(page).to have_content('Ask a Question')
      end
    end

    it 'can click on the home link and be taken back to the root page' do
      visit root_path

      within '.nav' do
        click_on ':: Kaizen ::'
      end

      expect(current_path).to eq(root_path)
    end

    it 'can register for an account' do
      visit root_path

      within '.nav' do
        within '#logInRight' do
          within '.dropdown-content' do
            click_on 'Register'
          end
        end
      end

      expect(current_path).to eq(new_user_registration_path)

      within '.new_user' do
        choose 'user_status_1'
        fill_in :user_first_name, with: 'firstname'
        fill_in :user_last_name, with: 'lastname'
        fill_in :user_cohort, with: 'cohort'
        fill_in 'Email', with: 'email@example.com'
        fill_in 'Password', with: 'newpass'
        fill_in 'Password confirmation', with: 'newpass'

        click_on 'Sign up'
      end

      expect(current_path).to eq(root_path)
      expect(page).to have_content('Welcome! You have signed up successfully.')
    end

    it 'I do not see a profile button in the nav bar' do
      visit root_path

      expect(page).not_to have_button('Profile')
    end
  end
end
