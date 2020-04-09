require 'rails_helper'

RSpec.describe 'As a User' do 
    describe 'When I log into the app as a valid user' do 
        before :each do 
            @user = create(:user)
            @user.confirm

            visit '/'

            click_on "Sign In"

            expect(current_path).to eq("/users/sign_in")

            fill_in :user_email, with: @user.email
            fill_in :user_password, with: @user.password

            click_on "Log in"

            expect(current_path).to eq("/")
        end

        it 'I can go anywhere in the site and see a profile button on the nav bar that will take me to my profile' do

            visit '/'

            expect(page).to have_button("Profile")

            click_on "Profile"
           
            expect(current_path).to eq(profile_path)
            expect(page).to have_content("Welcome!, you are currently logged in as #{@user.first_name} #{@user.last_name}.")
        end
    end
end
