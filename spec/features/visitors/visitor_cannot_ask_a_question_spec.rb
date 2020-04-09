require 'rails_helper'

RSpec.describe 'As a Visitor' do
    describe 'When I visit the welcome page' do
        it 'I cannot post a question' do
          visit '/'

          click_on "Ask a Question"

          expect(current_path).to eq('/users/sign_in')
          expect(page).to have_content("You need to sign in or sign up before continuing.")
        end
      end
    end
