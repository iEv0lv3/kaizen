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

    it 'I can see a link to add a comment to the question, when I fill this link out correctly I see my comment posted on the show page. ' do
      expect(page).to have_link('Leave a Comment')

      click_on 'Leave a Comment'

      expect(current_path).to eq("/questions/#{@question_1.id}/comments/new")

      fill_in :content, with: 'Yes I herd my instructor say that in class but I also have no idea what that is.'

      click_on 'Submit'

      expect(current_path).to eq("/questions/#{@question_1.id}")
      expect(Comment.last.user_id).to eq(@user_2.id)
      expect(page).to have_content('Your comment was successfully created!')
      expect(page).to have_content('Yes I herd my instructor say that in class but I also have no idea what that is.')
    end

    it 'I can see a link to add a comment to the question, when I fill this link out incorrectly I do not see my comment posted on the show page. ' do
      expect(page).to have_link('Leave a Comment')

      click_on 'Leave a Comment'

      expect(current_path).to eq("/questions/#{@question_1.id}/comments/new")

      fill_in :content, with: ' '

      click_on 'Submit'

      expect(current_path).to eq("/questions/#{@question_1.id}/comments/new")
      expect(page).to have_content("Content can't be blank")
      expect(page).not_to have_content('Yes I herd my instructor say that in class but I also have no idea what that is.')
    end

    it 'I cannot make a question if I use to many characters' do 
      expect(page).to have_link('Leave a Comment')

      click_on 'Leave a Comment'

      expect(current_path).to eq("/questions/#{@question_1.id}/comments/new")

      fill_in :content, with: "but why" * 100

      click_on 'Submit'

      expect(page).to have_content("Content 200 characters is the maximum allowed")
      expect(page).not_to have_content('Yes I herd my instructor say that in class but I also have no idea what that is.')
    end
  end
end
