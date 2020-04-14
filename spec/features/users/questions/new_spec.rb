require 'rails_helper'

RSpec.describe 'As a user' do
  describe 'I can create a new professional or technical question' do
    before :each do
      @user = create(:user)
      @user.confirm

      visit '/'

      expect(page).to have_content("Sign In")

      click_on "Sign In"

      expect(current_path).to eq('/users/sign_in')

      fill_in :user_email, with: @user.email
      fill_in :user_password, with: @user.password

      click_on "Log in"

      expect(current_path).to eq("/")
    end

    it "I can navigate from welcome page to post a new technical question" do
      visit '/questions/new'

      expect(page).to have_content("Post a Question:")

      subject = 'Ruby methods'
      content = 'What is reduce good for?'

      within '.new_question' do
        choose 'question_forum_0'
        fill_in :question_subject, with: subject
        fill_in :question_content, with: content
        click_on 'Submit Question'
      end

      expect(current_path).to eq('/technical_forum')
      expect(page).to have_content(subject)
      expect(page).to have_content(content)
      expect(page).to have_content("Your question was successfully submitted!")
    end

    it "I can navigate from welcome page to post a new professional question" do

      visit '/questions/new'

      expect(page).to have_content("Post a Question:")

      subject = 'Jobs'
      content = 'How do I get one?'

      within '.new_question' do
        choose 'question_forum_1'
        fill_in :question_subject, with: subject
        fill_in :question_content, with: content
        click_on 'Submit Question'
      end

      expect(current_path).to eq('/professional_forum')
      expect(page).to have_content(subject)
      expect(page).to have_content(content)
      expect(page).to have_content("Your question was successfully submitted!")
    end

    it "I cannot create a question without filling out proper information" do
      visit '/questions/new'

      expect(page).to have_content("Post a Question:")

      subject = 'Jobs'
      content = 'How do I get one?'

      within '.new_question' do
        choose 'question_forum_1'
        fill_in :question_subject, with: ""
        fill_in :question_content, with: content
        click_on 'Submit Question'
      end

      expect(current_path).to eq("/questions/new")
      expect(page).to have_content("Subject can't be blank")
    end
  end
end
