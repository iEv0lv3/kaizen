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

  def edit
    @question = Question.find(params[:question_id])
    @answer = Answer.find(params[:answer_id])
  end


  def update
    question = Question.find(params[:question_id])
		answer = Answer.find(params[:answer_id])
		answer.update(answer_params)
    if answer.save
      flash[:success] = "Your Answer was successfully updated!!"
	    redirect_to "/questions/#{question.id}"
    else
			flash[:error] = answer.errors.full_messages.to_sentence
			redirect_to "/questions/#{question.id}/answers/#{answer.id}/edit"
    end
  end

  def destroy
    question = Question.find(params[:question_id])
	  Answer.destroy(params[:answer_id])
    redirect_to "/questions/#{question.id}"
    flash[:notification] = "Your Answer was successfully deleted."
  end

    private

    def answer_params
        params.permit(:content)
    end
end
