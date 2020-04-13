require 'rails_helper'

RSpec.describe 'As a Visitor' do
  describe 'When I visit a questions show page I can click on the answers content' do
    before :each do
      user = create(:user)
      user.confirm

      @user_2 = create(:user)
      @user_2.confirm

      @question_1 = Question.create!(
        { subject: 'Ruby methods',
          content: 'What is attr_reader?',
          upvotes: 1,
          forum: 0,
          user_id: user.id }
      )

      @answer_1 = @question_1.answers.create!(
        { content: 'The attr_reader lets other read your code.',
          upvotes: 1,
          user_id: @user_2.id }
      )

      visit "/questions/#{@question_1.id}"

      expect(current_path).to eq("/questions/#{@question_1.id}")
    end

    it 'and if the answer is one that I made then I can delete it' do
      visit '/'

      expect(current_path).to eq('/')

      expect(page).to have_content('Sign In')

      click_on 'Sign In'

      expect(current_path).to eq('/users/sign_in')

      fill_in :user_email, with: @user_2.email
      fill_in :user_password, with: @user_2.password

      click_on 'Log in'

      expect(current_path).to eq('/')

      visit "/questions/#{@question_1.id}"

      expect(current_path).to eq("/questions/#{@question_1.id}")

      within "#answer-#{@answer_1.id}" do
        expect(page).to have_link('Delete')
        click_on 'Delete'
      end

      expect(current_path).to eq("/questions/#{@question_1.id}")

      expect(page).not_to have_content(@answer_1.content)
    end

    it 'and if the answer is not one that I made then I can not delete it' do
      user_3 = create(:user)
      user_3.confirm

      visit '/'

      expect(current_path).to eq('/')

      expect(page).to have_content('Sign In')

      click_on 'Sign In'

      expect(current_path).to eq('/users/sign_in')

      fill_in :user_email, with: user_3.email
      fill_in :user_password, with: user_3.password

      click_on 'Log in'

      expect(current_path).to eq('/')

      visit "/questions/#{@question_1.id}"

      expect(current_path).to eq("/questions/#{@question_1.id}")

      within "#answer-#{@answer_1.id}" do
        expect(page).not_to have_link('Delete')
      end
    end
  end
end
