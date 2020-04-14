require 'rails_helper'

RSpec.describe 'As a Visitor' do 
  describe 'When I visit a questions show page.' do 
    before :each do 
      user = create(:user)
      user.confirm

      @user_2 = create(:user)
      @user_2.confirm

      @user_3 = create(:user)
      @user_3.confirm

      @question_1 = Question.create!(
        {subject: "Ruby methods",
        content: "What is attr_reader?",
        upvotes: 1,
        forum: 0,
        user_id: user.id
      })

      @answer_1 = @question_1.answers.create!(
        {content: "The attr_reader lets other read your code.",
        upvotes: 1,
        user_id: @user_2.id

        })

      @comment_1 = @answer_1.comments.create!(
        {content: "I think this is a good start but also I know there is more to it. ",
        user_id: @user_3.id
        })

      @comment_2 = @answer_1.comments.create!(
        {content: "You might want to ask your mentor to explain it in greater detail.",
        user_id: @user_3.id
        })
    end

    it 'And that question has an answer, I can then see all the comments for that answer' do 

      visit "/questions/#{@question_1.id}"

      within "#answer-#{@answer_1.id}" do 
        expect(page).to have_content(@comment_1.content)
        expect(page).to have_content(@comment_2.content)
      end
    end
  end
end
