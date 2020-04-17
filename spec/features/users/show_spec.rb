require 'rails_helper'

RSpec.describe 'As a Visitor' do 
  describe 'When I click on the link provided anywhere on the site' do 
    before :each do 
      @user_1 = create(:user)
      @user_1.confirm
  
      @question_1 = Question.create!(
        {subject: 'Ruby methods',
        content: 'What is attr_reader?',
        upvotes: 1,
        forum: 0,
        user_id: @user_1.id 
      })
  
      visit "/questions/#{@question_1.id}"
    end

    it 'I can see a public view of a users profile' do

    expect(page).to have_link(@user_1.user_name)

    click_on @user_1.user_name

    expect(current_path).to eq("/users/#{@user_1.id}")

    expect(page).to have_content(@user_1.first_name)
    expect(page).to have_content(@user_1.last_name)
    expect(page).to have_content(@user_1.cohort)
    expect(page).to have_content(@user_1.user_name)
    expect(page).to have_content(@user_1.status.capitalize)
    end
  end
end



