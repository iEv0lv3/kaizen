require 'rails_helper'

RSpec.describe 'As a User' do 
    describe 'When I visit my profile' do 
        it 'By first logging in on the welcome page'

        visit '/'

        expect(page).to have_content("Login")