require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'validations' do
    it { should validate_presence_of :content }
  end

  describe 'relationships' do
    it { should belong_to :commentable }
    it { should belong_to :user }
    it { should have_many :votes }
  end

  describe '#increment_upvotes' do
    before :each do
      user_1 = User.create!(
        email: 'user_1@turing.io',
        user_name: 'user_1',
        password: 'user_1',
        first_name: 'User',
        last_name: '1',
        cohort: '1811',
        status: 1
      )

      question = Question.create!(
        subject: 'Ruby methods',
        content: 'What is attr_reader?',
        upvotes: 1,
        forum: 0,
        user_id: user_1.id
      )

      answer = Answer.create!(
        content: 'An answer to a question',
        upvotes: 1,
        question_id: question.id,
        user_id: user_1.id
      )

      @comment = answer.comments.create!(
        content: 'This is a comment',
        upvotes: 1,
        user_id: user_1.id
      )
    end

    it 'can increment upvotes' do
      expect(@comment.upvotes).to eq(1)

      @comment.increment_upvotes

      expect(@comment.upvotes).to eq(2)
    end
  end
end
