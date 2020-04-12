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

            @answer_1 = @question_1.answers.create!({content: "The attr_reader lets other read your code.",
                upvotes: 1,
                user_id: @user_2.id
            })

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

            expect(page).to have_content(@answer_1.content)
        end

        it 'I can edit an answer that I posted' do 

            within "#answer-#{@answer_1.id}" do 
                expect(page).to have_link("Edit")

                click_on "Edit"
            end

            expect(current_path).to eq("/questions/#{@question_1.id}/answers/#{@answer_1.id}/edit")

            fill_in :content, with: "An attr_reader is a method from a super class that allows other files to read the methods in the file the attr_reader is in."

            click_on "Submit"

            expect(current_path).to eq("/questions/#{@question_1.id}")

            within "#answer-#{@answer_1.id}" do 
                expect(page).to have_content("An attr_reader is a method from a super class that allows other files to read the methods in the file the attr_reader is in.")
                expect(page).not_to have_content(@answer_1.content)
            end

            expect(page).to have_content("Your Answer was successfully updated!!")

        end

        it 'I can edit an answer that I posted, but it will not edit if I leave the content blank.' do 

            within "#answer-#{@answer_1.id}" do 
                expect(page).to have_link("Edit")

                click_on "Edit"
            end

            expect(current_path).to eq("/questions/#{@question_1.id}/answers/#{@answer_1.id}/edit")

            fill_in :content, with: " "

            click_on "Submit"

            expect(current_path).to eq("/questions/#{@question_1.id}/answers/#{@answer_1.id}/edit")

            expect(page).to have_content("Content can't be blank")
        end

        it 'I cannot see an edit button on the answer unless it is one of my answers' do 

            user_3 = create(:user)
            user_3.confirm
            
            expect(page).to have_link("Sign Out")

            click_on "Sign Out"

            expect(current_path).to eq("/")

            expect(page).to have_content("Sign In")

            click_on "Sign In"

            expect(current_path).to eq('/users/sign_in')

            fill_in :user_email, with: user_3.email
            fill_in :user_password, with: user_3.password
            

            click_on "Log in"

            expect(current_path).to eq("/")

            visit "/questions/#{@question_1.id}"

            expect(current_path).to eq("/questions/#{@question_1.id}")

            expect(page).to have_content(@answer_1.content)

            within "#answer-#{@answer_1.id}" do 
                expect(page).not_to have_link("Edit")
            end
        end
    end
end


            
