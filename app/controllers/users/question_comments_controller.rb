class Users::QuestionCommentsController < Users::BaseController
  def new
    @question = Question.find(params[:question_id])  
  end

  def create
    question = Question.find(params[:question_id])
    comment = question.comments.new(comment_params)

    if comment.save
      redirect_to "/questions/#{question.id}"
      flash[:success] = 'Your comment was successfully created! '
    else
      redirect_to "/questions/#{question.id}/comments/new"
      flash[:warning] = comment.errors.full_messages.to_sentence
    end
  end

  private 
  
  def comment_params
    params.permit(:content)
  end
  
end