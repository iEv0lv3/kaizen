require 'rails_helper'

RSpec.describe 'As a user' do
  before :each do
    @user_1 = create(:user)
    @user_2 = create(:user)
    @user_3 = create(:user)

    @user_1.confirm

    visit root_path

    click_on 'Sign In'

    fill_in :user_email, with: @user_1.email
    fill_in :user_password, with: @user_1.password

    click_on 'Log in'

    @question = Question.create!(
      subject: 'User Question',
      content: 'This is a question written by a user',
      forum: 0,
      upvotes: 3,
      user_id: @user_1.id
    )

    @answer_1 = @question.answers.create!(
      content: 'This is the best answer to user_1s question',
      user_id: @user_2.id,
      upvotes: 30,
      verification: 0
    )

    @answer_2 = @question.answers.create!(
      content: 'This is the second best answer to user_1s question',
      user_id: @user_3.id,
      upvotes: 10,
      verification: 0
    )
  end

  it 'can verify an answer on a question' do
    visit question_show_path(@question)

    within "#answer-#{@answer_1.id}" do
      click_on 'Verify Answer'
    end

    within "#answer-#{@answer_1.id}" do
      expect(page).to have_css('.verification')
    end
  end
end
