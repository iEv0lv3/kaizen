require 'rails_helper'

RSpec.describe 'As a User' do
  before :each do
    @user_1 = create(:user)
    @user_1.confirm

    @user_2 = create(:user)
    @user_2.confirm

    @user_3 = create(:user)
    @user_3.confirm

    @question_1 = Question.create!(
      subject: 'Ruby methods',
      content: 'What is attr_reader?',
      upvotes: 1,
      forum: 0,
      user_id: @user_1.id
    )

    @question_2 = Question.create!(
      subject: 'Rails',
      content: 'MVC?',
      upvotes: 1,
      forum: 0,
      user_id: @user_2.id
    )

    @question_comment = @question_1.comments.create!(
      content: "Great question, interested in response!",
      user_id: @user_2.id
    )

    @answer_1 = @question_1.answers.create!(
      content: "A way to give access to methods outside the class",
      user_id: @user_2.id
    )

    @answer_comment = @answer_1.comments.create(
      content: "This answer worked for me",
      user_id: @user_3.id
    )

    visit '/'

    expect(page).to have_content('Sign In')

    click_on 'Sign In'

    expect(current_path).to eq('/users/sign_in')

    fill_in :user_email, with: @user_1.email
    fill_in :user_password, with: @user_1.password

    click_on 'Log in'
  end

  it 'can upvote a question on its show page' do
    visit "/questions/#{@question_2.id}"

    within '.question' do
      click_on 'Upvote'
      expect(page).to have_content("#{@question_2.subject} :: 2")
    end
  end

  it 'can upvote a comment on a question' do
    visit "/questions/#{@question_1.id}"

    expect(@question_comment.upvotes).to eq(1)

    within "#upvote-#{@question_comment.id}" do
      expect(page).to have_content('1 ::')
      click_link 'Upvote'
    end

    expect(current_path).to eq("/questions/#{@question_1.id}")

    within "#upvote-#{@question_comment.id}" do
      expect(page).not_to have_content 'Upvote'
      expect(page).to have_content('2 ::')
    end
  end

  it 'I can upvote an answer to a question' do
    visit "/questions/#{@question_1.id}"

    within "#answer-upvotes-#{@answer_1.id}" do
      click_on 'Upvote'
    end

    expect(page).to have_content("Answer :: 2")
  end

  it 'I can upvote a comment on an answer' do
    visit "/questions/#{@question_1.id}"

    within "#answer-comment-upvote-#{@answer_comment.id}" do
      click_on 'upvote'
    end

    expect(current_path).to eq("/questions/#{@question_1.id}")

    within "#answer-comment-#{@answer_comment.id}" do
      expect(page).not_to have_content 'Upvote'
      expect(page).to have_content('2 ::')
    end
  end
end
