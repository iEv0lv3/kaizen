require 'rails_helper'

RSpec.describe 'As a Visitor' do
  describe 'When i visit a questions show page' do
    before :each do
      user = create(:user)
      user.confirm

      @question_1 = Question.create!(
        { subject: 'Ruby methods',
          content: 'What is attr_reader?',
          upvotes: 1,
          forum: 0,
          user_id: user.id }
      )

      user_2 = create(:user)
      user_2.confirm

      @comment_1 = @question_1.comments.create!(
        { content: 'Yes I herd my instructor say that in class but I also have no idea what that is.',
          user_id: user_2.id }
      )

      @comment_2 = @question_1.comments.create!(
        { content: 'In parcial to my before Comment, is there anyone who might be able to pair with me on this?',
          user_id: user_2.id }
      )
    end

    it 'I can see all the comments left for that question' do
      visit "/questions/#{@question_1.id}"

      expect(page).to have_content(@comment_1.content)
      expect(page).to have_content(@comment_2.content)
    end
  end
end
