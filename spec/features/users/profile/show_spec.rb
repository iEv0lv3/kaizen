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
end
