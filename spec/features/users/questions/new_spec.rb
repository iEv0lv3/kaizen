require 'rails_helper'

RSpec.describe 'As a user' do
  describe 'I can create a new professional or technical question' do
    before :each do
      @user = create(:user)
      @user.confirm
    end

    it "I can navigate from welcome page to post a new technical question" do
      visit '/questions/new'

      expect(page).to have_content("Post a Question:")

      subject = 'Ruby methods'
      content = 'What is reduce good for?'

      within


    end
  end
end
