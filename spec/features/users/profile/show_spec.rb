require 'rails_helper'

RSpec.describe 'As a User' do 
    describe 'When I visit my profile' do
        it 'By first logging in on the welcome page' do 
            user = create(:user)
            user.confirm

            visit '/'

            expect(page).to have_content("Sign In")

            click_on "Sign In"

            expect(current_path).to eq('/users/sign_in')

            fill_in :user_email, with: user.email
            fill_in :user_password, with: user.password
            

            click_on "Log in"

            expect(current_path).to eq("/")
        end
    end

    describe 'When I am on my profile page' do 
        before :each do 
            @user = create(:user)
            @user.confirm

            visit '/'

            expect(page).to have_content("Sign In")

            click_on "Sign In"

            expect(current_path).to eq('/users/sign_in')

            fill_in :user_email, with: @user.email
            fill_in :user_password, with: @user.password
            

            click_on "Log in"

            expect(current_path).to eq("/")

            click_on "Profile"

            expect(current_path).to eq(profile_path)
        end

        it 'I can see all of my information' do 

            expect(page).to have_content(@user.avatar)
            expect(page).to have_content(@user.first_name)
            expect(page).to have_content(@user.last_name)
            expect(page).to have_content(@user.cohort)
            expect(page).to have_content(@user.status)
        end 
    end 
end
