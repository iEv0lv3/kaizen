require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of :encrypted_password }
    it { should validate_presence_of :user_name}
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
    it { should validate_presence_of :cohort }
    it { should validate_presence_of :status }
  end

  describe 'relationships' do
    it { should have_many :questions }
    it { should have_many :answers }
    it { should have_many :comments }
    it { should have_many :votes }
  end

  describe '#award_count' do
    it 'sends back an award count', :vcr do
      user_1 = User.create(
        email: 'user_1@turing.io',
        password: 'user_1',
        first_name: 'User',
        last_name: '1',
        cohort: '1811',
        status: 1,
        so_uid: 4947551,
        gh_login: 'iEv0lv3'
      )

      expect(user_1.award_count).to eq(1)

      user_2 = User.create(
        email: 'user_1@turing.io',
        password: 'user_1',
        first_name: 'User',
        last_name: '1',
        cohort: '1811',
        status: 1,
        so_uid: 7274890,
        gh_login: 'alerrian'
      )

      expect(user_2.award_count).to eq(0)
    end
  end

  describe 'my_medals' do
    before :each do
      @user = User.create!(
        email: 'user@turing.io',
        user_name: 'iEv0lv3',
        password: 'user_1',
        first_name: 'User',
        last_name: '1',
        cohort: '1811',
        status: 1,
        so_uid: 4947551,
        gh_login: 'iEv0lv3'
      )

      @user2 = User.create!(
        email: 'user2@turing.io',
        user_name: 'iEv0lv32',
        password: 'user_1',
        first_name: 'User',
        last_name: '1',
        cohort: '1811',
        status: 1,
        so_uid: 4947551,
        gh_login: 'iEv0lv3'
      )

      @user3 = User.create!(
        email: 'user3@turing.io',
        password: 'user_1',
        user_name: 'iEv0lv33',
        first_name: 'User',
        last_name: '1',
        cohort: '1811',
        status: 1,
        so_uid: 4947551,
        gh_login: 'iEv0lv3'
      )

      @user4 = User.create!(
        email: 'user4@turing.io',
        password: 'user_1',
        user_name: 'iEv0lv333',
        first_name: 'User',
        last_name: '1',
        cohort: '1811',
        status: 1,
        so_uid: 4947551,
        gh_login: 'iEv0lv3'
      )

      16.times do
        @question_1 = @user.questions.create!(
          subject: 'Ruby methods',
          content: 'What is attr_reader?',
          upvotes: 1,
          forum: 0
        )
      end

      10.times do
        @question_2 = @user2.questions.create!(
          subject: 'Jobs',
          content: "Why can't I get a job?",
          upvotes: 1,
          forum: 1
        )
      end

      5.times do
        @comment_1 = @question_1.comments.create!(
          content: 'An amazing comment part 1',
          user_id: @user3.id
        )
      end

      3.times do
        @comment_2 = @question_1.comments.create!(
          content: 'An amazing comment part 1',
          user_id: @user4.id
        )
      end
    end

    it 'my_medals' do
      expect(@user4.my_medals).to eq('kaizen_award_green.png')
      expect(@user3.my_medals).to eq('kaizen_award_blue.png')
      expect(@user2.my_medals).to eq('kaizen_award_red.png')
      expect(@user.my_medals).to eq('kaizen_award_yellow.png')
    end


    it 'my_answers' do
      expect(@user.my_answers).to eq(0)
    end

    it 'my_questions' do
      expect(@user.my_questions).to eq(16)
      expect(@user2.my_questions).to eq(10)
    end

    it 'my_comments' do
      expect(@user.my_comments).to eq(0)
      expect(@user3.my_comments).to eq(5)
    end
  end
end
