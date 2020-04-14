require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'When I visit one of the questions index page' do
    before :each do
      user = create(:user)
      user.confirm

      @question_1 = Question.create!({subject: "Ruby methods",
                                      content: "What is attr_reader?",
                                      upvotes: 1,
                                      forum: 0,
                                      user_id: user.id})

      @question_2 = Question.create!({subject: "Jobs",
                                      content: "Why can't I get a job?",
                                      upvotes: 1,
                                      forum: 1,
                                      user_id: user.id})

      @question_3 = Question.create!({subject: "Ruby accessors",
                                      content: "What is attr_accessor?",
                                      upvotes: 1,
                                      forum: 0,
                                      user_id: user.id})

      @question_4 = Question.create!({subject: "Interviews",
                                      content: "Best interview practices",
                                      upvotes: 1,
                                      forum: 1,
                                      user_id: user.id})
    end

    it 'I can click on a question subject in technical index and be taken to its show page' do
      visit '/'

      click_on 'Technical'

      expect(current_path).to eq('/technical_forum')

      within "#question-#{@question_1.id}" do
        expect(page).to have_link(@question_1.subject)
        click_on @question_1.subject
      end

      expect(current_path).to eq("/questions/#{@question_1.id}")

      expect(page).to have_content(@question_1.subject)
      expect(page).to have_content(@question_1.content)
      expect(page).to have_content(@question_1.upvotes)
      expect(page).not_to have_content(@question_3.subject)
      expect(page).not_to have_content(@question_3.content)
    end

    it "I can click on a question subject in professional index and be taken to a question show page" do
      visit '/'

      click_on 'Professional'

      expect(current_path).to eq('/professional_forum')

      within "#question-#{@question_2.id}" do
        expect(page).to have_link(@question_2.subject)
        click_on @question_2.subject
      end

      expect(current_path).to eq("/questions/#{@question_2.id}")

      expect(page).to have_content(@question_2.subject)
      expect(page).to have_content(@question_2.content)
      expect(page).to have_content(@question_2.upvotes)
      expect(page).not_to have_content(@question_4.subject)
      expect(page).not_to have_content(@question_4.content)
    end
  end

  describe 'As a User' do 
    describe 'I can delete any question comments that I made' do 
      before :each do 
        user = create(:user)
        user.confirm

        @question_1 = Question.create!(
          {subject: "Ruby methods",
          content: "What is attr_reader?",
          upvotes: 1,
          forum: 0,
          user_id: user.id
        })

        @user_2 = create(:user)
        @user_2.confirm

        @comment_1 = @question_1.comments.create!(
          {content: "Yes I herd my instructor say that in class but I also have no idea what that is.",
          user_id: @user_2.id
        })

        visit '/'

        expect(page).to have_content("Sign In")

        click_on "Sign In"

        expect(current_path).to eq('/users/sign_in')

        fill_in :user_email, with: @user_2.email
        fill_in :user_password, with: @user_2.password

        click_on "Log in"

        expect(current_path).to eq("/")

        visit "/questions/#{@question_1.id}"
      end

      it 'within the questions show page' do 

        within "#question_comment-#{@comment_1.id}" do 
          expect(page).to have_link("Delete")
          click_on "Delete"
        end

        expect(current_path).to eq("/questions/#{@question_1.id}")

        expect(page).not_to have_content(@comment_1.content)
        expect(page).to have_content("Your Comment was successfully deleted!")
      end

      it 'within the questions show page, unless I did not make the comment then I cannot see the link' do 
        user_3 = create(:user)
        user_3.confirm

        click_on "Sign Out"

        expect(current_path).to eq("/")

        click_on "Sign In"

        expect(current_path).to eq('/users/sign_in')

        fill_in :user_email, with: user_3.email
        fill_in :user_password, with: user_3.password

        click_on "Log in"

        expect(current_path).to eq("/")

        visit "/questions/#{@question_1.id}"

        within "#question_comment-#{@comment_1.id}" do 
          expect(page).not_to have_link("Delete")
        end
      end
    end
  end
end
