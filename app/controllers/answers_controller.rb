class AnswersController < ApplicationController

    def show
        @answer = Answer.find(params[:id])
    end

    def new 
        @question = Question.find(params[:id])
    end

    def create
		question = Question.find(params[:id])
        answer = question.answers.new(answer_params)
        answer.user_id = current_user.id 

		if answer.save
            redirect_to "/questions/#{question.id}"
            flash[:success] = "Your answer was successfully created! "
		else
			redirect_to "/questions/#{question.id}/answers/new"
			flash[:error] = answer.errors.full_messages.to_sentence
		end
    end
    
    private 

    def answer_params
        params.permit(:content)
    end
end