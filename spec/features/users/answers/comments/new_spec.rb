require 'rails_helper'

RSpec.describe 'As a user' do
  describe 'When I visit a questions show page' do
    describe 'If that question has answers' do
      before :each do
        @user = create(:user)
        @user.confirm

        @user_2 = create(:user)
        @user_2.confirm

        @question_1 = Question.create!(
          { subject: 'Ruby methods',
            content: 'What is attr_reader?',
            upvotes: 1,
            forum: 0,
            user_id: @user.id }
        )

        @answer_1 = @question_1.answers.create!(
          { content: 'The attr_reader lets other read your code.',
            upvotes: 1,
            user_id: @user_2.id }
        )

        visit '/'

        expect(page).to have_content('Sign In')

        click_on 'Sign In'

        expect(current_path).to eq('/users/sign_in')

        fill_in :user_email, with: @user_2.email
        fill_in :user_password, with: @user_2.password

        click_on 'Log in'

        expect(current_path).to eq('/')

        visit "/questions/#{@question_1.id}"
      end

      it 'I can add comments to the answer' do
        within "#answer-#{@answer_1.id}" do
          expect(page).to have_link('Leave a Comment')
          click_on 'Leave a Comment'
        end

        expect(current_path).to eq("/questions/#{@question_1.id}/answers/#{@answer_1.id}/comments/new")

        fill_in :content, with: 'I think this is a good start but also I know there is more to it.'

        click_on 'Submit'

        expect(current_path).to eq("/questions/#{@question_1.id}")
        expect(Comment.last.user_id).to eq(@user_2.id)
        expect(page).to have_content('I think this is a good start but also I know there is more to it.')
        expect(page).to have_content('Your comment was successfully created!')
      end

      it 'I can not add comments to the answer if my information is blank' do
        within "#answer-#{@answer_1.id}" do
          expect(page).to have_link('Leave a Comment')
          click_on 'Leave a Comment'
        end

        expect(current_path).to eq("/questions/#{@question_1.id}/answers/#{@answer_1.id}/comments/new")

        fill_in :content, with: ''

        click_on 'Submit'

        expect(current_path).to eq("/questions/#{@question_1.id}/answers/#{@answer_1.id}/comments/new")
        expect(page).not_to have_content('I think this is a good start but also I know there is more to it.')
        expect(page).to have_content("Content can't be blank")
      end

      it 'I can not make a comment answer if the content is over 200.' do
        within "#answer-#{@answer_1.id}" do
          expect(page).to have_link('Leave a Comment')
          click_on 'Leave a Comment'
        end

        expect(current_path).to eq("/questions/#{@question_1.id}/answers/#{@answer_1.id}/comments/new")

        fill_in :content, with: "I am sorry" * 300 

        click_on 'Submit'

        expect(page).not_to have_content('I think this is a good start but also I know there is more to it.')
        expect(page).to have_content("Content 200 characters is the maximum allowed")
      end
    end
  end
end
