require 'rails_helper'

RSpec.describe 'As a User' do
  describe 'When I visit my profile page' do
    before :each do
      @user = User.create!({email: "user_1@turing.io",
                            password: "password",
                            first_name: "Luther",
                            last_name: "Van Draws",
                            cohort: "1811",
                            status: 1,
                            user_name: "Luther123"})
      @user.confirm

      visit '/'

      expect(page).to have_content('Sign In')

      click_on 'Sign In'

      expect(current_path).to eq('/users/sign_in')

      fill_in :user_email, with: @user.email
      fill_in :user_password, with: @user.password

      click_on 'Log in'

      expect(current_path).to eq('/')

      click_on 'Profile'

      expect(current_path).to eq(profile_path)
    end

    it 'I can edit my profile' do
      expect(page).to have_link('Edit')

      click_on 'Edit'

      expect(current_path).to eq('/profile/edit')

      fill_in :last_name, with: 'McFakerson'

      click_on 'Submit'

      expect(current_path).to eq('/profile')

      expect(page).to have_content('McFakerson')
      expect(page).not_to have_content(@user.last_name)
    end

    it 'I can edit my password seperately from editing my profile' do
      expect(page).to have_link('Change your password')

      click_on 'Change your password'

      expect(current_path).to eq('/users/edit')

      fill_in :user_password, with: 'FakePassword'
      fill_in :user_password_confirmation, with: 'FakePassword'
      fill_in :user_current_password, with: @user.password

      click_on 'Update'

      expect(current_path).to eq('/')
    end

    it "I cannot leave first name blank when editing my profile" do
      expect(page).to have_link('Edit')
      click_on 'Edit'

      expect(current_path).to eq('/profile/edit')

      fill_in :first_name, with: ""

      click_on 'Submit'

      expect(current_path).to eq('/profile/edit')

      expect(page).to have_content("First name can't be blank")
    end

    it "I cannot leave last name blank when editing my profile " do
      expect(page).to have_link('Edit')

      click_on 'Edit'

      expect(current_path).to eq('/profile/edit')

      fill_in :last_name, with: ''

      click_on 'Submit'

      expect(current_path).to eq('/profile/edit')

      expect(page).to have_content("Last name can't be blank")
    end

    it "I cannot leave cohort blank when editing my profile" do
      expect(page).to have_link('Edit')

      click_on 'Edit'

      expect(current_path).to eq('/profile/edit')

      fill_in :cohort, with: ''

      click_on 'Submit'

      expect(current_path).to eq('/profile/edit')
      
      expect(page).to have_content("Cohort can't be blank")
    end
  end
end
