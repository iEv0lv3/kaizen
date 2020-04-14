class Users::AnswersController < Users::BaseController
  def new
    @question = Question.find(params[:question_id])
  end

  def create
    question = Question.find(params[:question_id])
    answer = question.answers.new(answer_params)
    answer.user_id = current_user.id

    if answer.save
      redirect_to "/questions/#{question.id}"
      flash[:success] = 'Your answer was successfully created! '
    else
      redirect_to "/questions/#{question.id}/answers/new"
      flash[:warning] = answer.errors.full_messages.to_sentence
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
      flash[:success] = 'Your Answer was successfully updated!!'
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
    flash[:success] = 'Your Answer was successfully deleted.'
  end

  def upvote
    answer = Answer.find(params[:id].to_i)
    question = Question.find(answer.question_id)
    vote = answer.votes.new
    vote.user_id = current_user.id
    vote.save

    answer.update_column(:upvotes, answer.upvotes += 1)
    redirect_to "/questions/#{question.id}"
  end

  private

  def answer_params
    params.permit(:content)
  end
end
