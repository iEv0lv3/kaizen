require 'rails_helper'

RSpec.describe 'As a User' do
  before :each do
    @user_1 = create(:user)
    @user_1.confirm

    @user_2 = create(:user)
    @user_2.confirm

    @question_1 = Question.create!(
      subject: 'Ruby methods',
      content: 'What is attr_reader?',
      upvotes: 1,
      forum: 0,
      user_id: @user_1.id
    )

    visit '/'

    expect(page).to have_content('Sign In')

    click_on 'Sign In'

    expect(current_path).to eq('/users/sign_in')

    fill_in :user_email, with: @user_2.email
    fill_in :user_password, with: @user_2.password

    click_on 'Log in'
  end

  it 'can upvote a question on its show page' do
    visit "/questions/#{@question_1.id}"

    within '.question' do
      click_on 'Upvote'
      expect(page).to have_content("#{@question_1.subject} :: 2")
    end
  end
end
