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

        expect(current_path).to eq(root_path)
      end
    end
  end
end
