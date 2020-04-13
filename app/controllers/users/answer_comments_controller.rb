class Users::AnswerCommentsController < Users::BaseController 

  def new
    @question = Question.find(params[:question_id])
    @answer = Answer.find(params[:answer_id])
  end

  def create
    question = Question.find(params[:question_id])
    answer = Answer.find(params[:answer_id])
    comment = answer.comments.new(comment_params)

    if comment.save
      redirect_to "/questions/#{question.id}"
      flash[:success] = 'Your comment was successfully created! '
    else
      redirect_to "/questions/#{question.id}/answers/#{answer.id}/comments/new"
      flash[:warning] = comment.errors.full_messages.to_sentence
    end
  end

  private 
  
  def comment_params
    params.permit(:content)
  end
end