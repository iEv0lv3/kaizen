require 'rails_helper'

RSpec.describe 'As a Visitor' do 
    describe 'When I visit a questions show page I can click on the answers content'  do
        before :each do 
            user = create(:user)
            user.confirm

            user_2 = create(:user)
            user_2.confirm
      
            @question_1 = Question.create!({subject: "Ruby methods",
                                            content: "What is attr_reader?",
                                            upvotes: 1,
                                            forum: 0,
                                            user_id: user.id})

            @answer_1 = @question_1.answers.create!({content: "The attr_reader lets other read your code.",
                upvotes: 1,
                user_id: user_2.id
            })

            visit "/technical_forum/#{@question_1.id}"
    
            expect(current_path).to eq("/technical_forum/#{@question_1.id}")

        end

        it 'and I go to the answers show page. ' do 

            expect(page).to have_link(@answer_1.content)

            click_on @answer_1.content

            expect(current_path).to eq("/answers/#{@answer_1.id}")

            expect(page).to have_content(@answer_1.content)
        end
    end
end
