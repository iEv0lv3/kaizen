require 'rails_helper'

RSpec.describe 'As a User' do
  describe 'When I visit a questions show page' do
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

      @comment_1 = @question_1.comments.create!(
        { content: 'Yes I herd my instructor say that in class but I also have no idea what that is.',
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

    it 'I can edit a comment only if I have left the comment' do
      within "#question-comment-#{@comment_1.id}" do
        expect(page).to have_link('Edit')
        click_on 'Edit'
      end

      expect(current_path).to eq("/questions/#{@question_1.id}/comments/#{@comment_1.id}/edit")

      fill_in :content, with: 'I am in mod one and I herd my instructor say this in class.'

      click_on 'Submit'

      expect(current_path).to eq("/questions/#{@question_1.id}")
      expect(page).to have_content('Your Comment was successfully updated!!')
      expect(page).to have_content('I am in mod one and I herd my instructor say this in class.')
      expect(page).not_to have_content(@comment_1.content)
    end

    it 'I cannot edit a comment if I have not left the comment' do
      user_3 = create(:user)
      user_3.confirm

      click_on 'Sign Out'

      expect(current_path).to eq('/')

      expect(page).to have_content('Sign In')

      click_on 'Sign In'

      expect(current_path).to eq('/users/sign_in')

      fill_in :user_email, with: user_3.email
      fill_in :user_password, with: user_3.password

      click_on 'Log in'

      expect(current_path).to eq('/')

      visit "/questions/#{@question_1.id}"

      within "#question-comment-#{@comment_1.id}" do
        expect(page).not_to have_link('Edit')
      end
    end

    it "When I go to edit a comment I cannot leave the comment field blank or I will see an error message" do

      within "#question-comment-#{@comment_1.id}" do
        expect(page).to have_link('Edit')
        click_on 'Edit'
      end

      expect(current_path).to eq("/questions/#{@question_1.id}/comments/#{@comment_1.id}/edit")

      click_on 'Submit'

      expect(current_path).to eq("/questions/#{@question_1.id}/comments/#{@comment_1.id}/edit")
      expect(page).to have_content("Content can't be blank")
    end
  end
end
