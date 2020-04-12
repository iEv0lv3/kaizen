require 'rails_helper'

RSpec.describe 'As a Visitor' do 
    describe 'When I visit a questions show page' do 
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

            @question_2 = Question.create!({subject: "Jobs",
                                            content: "Why can't I get a job?",
                                            upvotes: 1,
                                            forum: 1,
                                            user_id: user.id})
            
            @answer_1 = @question_1.answers.create!({content: "The attr_reader lets other read your code.",
                                                     upvotes: 1,
                                                     user_id: user_2.id

            })

            @answer_2 = @question_1.answers.create!({content: "the attr_reader allows methods in the file to be read by other files.",
                                                     upvotes: 1,
                                                     user_id: user_2.id

            })

            @answer_3 = @question_2.answers.create!({content: "Because you are not trying. ",
                                                     upvotes: 1,
                                                     user_id: user_2.id

            })

            @answer_4 = @question_2.answers.create!({content: "Jobs are hard to come by, remember turing has a staff that you can reach out to to help you get there. hang in there.",
                                                     upvotes: 1,
                                                     user_id: user_2.id

            })

        end
        
        
        it 'I see a list of answers to that quesiton if it is a technical question' do 

            visit "/technical_forum/#{@question_1.id}"
    
            expect(current_path).to eq("/technical_forum/#{@question_1.id}")

            expect(page).to have_content(@answer_1.content)
            expect(page).to have_content(@answer_2.content)

        end

        it 'I see a list of answers to that quesiton if it is a professional question. ' do 

            visit "/professional_forum/#{@question_2.id}"
    
            expect(current_path).to eq("/professional_forum/#{@question_2.id}")

           expect(page).not_to have_content(@answer_1.content)
           expect(page).not_to have_content(@answer_2.content)

        end
    end
end
