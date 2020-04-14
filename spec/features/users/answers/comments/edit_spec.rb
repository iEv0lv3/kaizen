require 'rails_helper'

RSpec.describe 'As a User' do
  describe 'When I visit a questions show page' do
    describe 'And I left a comment in one of the quewtions answers' do
      before :each do
        @user = create(:user)
        @user.confirm

        @user_2 = create(:user)
        @user_2.confirm

        @user_3 = create(:user)
        @user_3.confirm

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

        @comment_1 = @answer_1.comments.create!(
          { content: 'Yes I herd my instructor say that in class but I also have no idea what that is.',
            user_id: @user_3.id }
        )

        visit '/'

        expect(page).to have_content('Sign In')

        click_on 'Sign In'

        expect(current_path).to eq('/users/sign_in')

        fill_in :user_email, with: @user_3.email
        fill_in :user_password, with: @user_3.password

        click_on 'Log in'

        expect(current_path).to eq('/')

        visit "/questions/#{@question_1.id}"
      end

      it 'I can see a link to edit my comment, when I click it if I enter in the info correctly I can update my comment ' do
        within "#answer-comment-#{@comment_1.id}" do
          expect(page).to have_link('Edit')
          click_on 'Edit'
        end

        expect(current_path).to eq("/questions/#{@question_1.id}/answers/#{@answer_1.id}/comments/#{@comment_1.id}/edit")

        fill_in :content, with: 'I am a mod 1 student so I am not sure if this is right but I think you can read another persons files.'

        click_on 'Submit'

        expect(current_path).to eq("/questions/#{@question_1.id}")

        expect(page).to have_content('Your Comment was successfully updated!!')

        within "#answer-comment-#{@comment_1.id}" do
          expect(page).to have_content('I am a mod 1 student so I am not sure if this is right but I think you can read another persons files.')
          expect(page).not_to have_content(@comment_1.content)
        end
      end

      it 'I can not see a link to edit my comment, If I did not make that comment' do
        user_4 = create(:user)
        user_4.confirm

        click_on 'Sign Out'

        expect(current_path).to eq('/')

        expect(page).to have_content('Sign In')

        click_on 'Sign In'

        expect(current_path).to eq('/users/sign_in')

        fill_in :user_email, with: user_4.email
        fill_in :user_password, with: user_4.password

        click_on 'Log in'

        expect(current_path).to eq('/')

        visit "/questions/#{@question_1.id}"

        within "#answer-comment-#{@comment_1.id}" do
          expect(page).not_to have_link('Edit')
        end
      end
    end
  end
end
