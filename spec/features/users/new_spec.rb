require 'rails_helper'

RSpec.describe 'As a Visitor' do 
    describe 'When I visit the welcome page' do 
        it 'I can register as a new user' do

            visit '/'

            expect(page).to have_content("Register")

            click_on "Register"

            expect(current_path).to eq("/users/sign_up")

            fill_in :user_email, with: "faker@fake.com"
            fill_in :user_password, with: "Fakeymcfackerson"
            fill_in :user_password_confirmation, with: "Fakeymcfackerson"

            click_on "Sign up"

            expect(current_path).to eq("/users")
        end
    end
end

