require 'rails_helper'

RSpec.describe Question, type: :model do
  describe 'validations' do
    it { should validate_presence_of :subject }
    it { should validate_presence_of :content }
    it { should validate_presence_of :forum }
  end
  describe 'relationships' do
    it { should belong_to :user }
    it { should have_many :comments }
    it { should have_many :answers }
    it { should have_many :votes }
  end

  describe 'methods' do
    before :each do
      @user = create(:user)
      @user.confirm

      @question_1 = Question.create!({ subject: 'Ruby methods',
                                       content: 'What is attr_reader?',
                                       upvotes: 1,
                                       forum: 0,
                                       user_id: @user.id })

      @question_2 = Question.create!({ subject: 'Jobs',
                                       content: "Why can't I get a job?",
                                       upvotes: 1,
                                       forum: 1,
                                       user_id: @user.id })

      @question_3 = Question.create!({ subject: 'Ruby methods',
                                       content: 'What is attr_accessor?',
                                       upvotes: 1,
                                       forum: 0,
                                       user_id: @user.id })

      @question_4 = Question.create!({ subject: 'Interviews',
                                       content: 'Best interview practices',
                                       upvotes: 1,
                                       forum: 1,
                                       user_id: @user.id })
    end

    it 'technical questions' do
      expect(Question.technical_questions).to eq([@question_3, @question_1])
    end

    it 'professional questions' do
      expect(Question.professional_questions).to eq([@question_4, @question_2])
    end

    it 'can increment upvotes' do
      expect(@question_1.upvotes).to eq(1)

      @question_1.increment_upvotes

      expect(@question_1.upvotes).to eq(2)
    end

    it 'can have a verified answer' do
      answer = @question_1.answers.create!(
        content: 'An answer to a question',
        upvotes: 1,
        user_id: @user.id
      )

      expect(@question_1.has_verified_answer?).to eq(false)

      answer.verify_answer
      answer.save

      expect(@question_1.has_verified_answer?).to eq(true)
    end
  end
end
