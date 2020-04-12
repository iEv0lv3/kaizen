require 'rails_helper'

RSpec.describe 'As a User' do 
    describe 'When I visit a questions show page' do 
        before :each do 
            @user = create(:user)
            @user.confirm

            @user_2 = create(:user)
            @user_2.confirm
      
            @question_1 = Question.create!({subject: "Ruby methods",
                                            content: "What is attr_reader?",
                                            upvotes: 1,
                                            forum: 0,
                                            user_id: @user.id})

            visit '/'

            expect(page).to have_content("Sign In")

            click_on "Sign In"

            expect(current_path).to eq('/users/sign_in')

            fill_in :user_email, with: @user_2.email
            fill_in :user_password, with: @user_2.password
            

            click_on "Log in"

            expect(current_path).to eq("/")

            visit "/questions/#{@question_1.id}"

            expect(current_path).to eq("/questions/#{@question_1.id}")

        end
                                
            
        it 'I can create a new answer to the question' do 

            expect(page).to have_button("Answer Question")

            click_on "Answer Question"

            expect(current_path).to eq("/answers/new")

            fill_in :conent, with: "An attr_reader is a method from a super class that allows other files to read the methods in the file the attr_reader is in."

            click_on "Submit"

            expect(current_path).to eq("/questions/#{@question_1.id}")

            expect(page).to have_content("An attr_reader is a method from a super class that allows other files to read the methods in the file the attr_reader is in.")
            expect(page).to have_content("Your answer was successfully created! ")
        end

        it 'I can create a new answer to the question, but it will not post if the content is blank' do 

            expect(page).to have_button("Answer Question")

            click_on "Answer Question"

            expect(current_path).to eq("/answers/new")

            fill_in :conent, with: " "

            click_on "Submit"

            expect(page).not_to have_content("An attr_reader is a method from a super class that allows other files to read the methods in the file the attr_reader is in.")
            expect(page).to have_content("Sorry, your answer was not created. Please make sure you filled in all fields.")
        end
    end
end
