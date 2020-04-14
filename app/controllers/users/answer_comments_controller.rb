class Users::AnswerCommentsController < Users::BaseController 

  def new
    @question = Question.find(params[:question_id])
    @answer = Answer.find(params[:answer_id])
  end

  def create
    question = Question.find(params[:question_id])
    answer = Answer.find(params[:answer_id])
    comment = answer.comments.new(comment_params)
    comment.user_id = current_user.id 

    if comment.save
      redirect_to "/questions/#{question.id}"
      flash[:success] = 'Your comment was successfully created! '
    else
      redirect_to "/questions/#{question.id}/answers/#{answer.id}/comments/new"
      flash[:warning] = comment.errors.full_messages.to_sentence
    end
  end

  def edit
    @question = Question.find(params[:question_id])
    @answer = Answer.find(params[:answer_id])
    @comment = Comment.find(params[:comment_id])
  end

  def update
    question = Question.find(params[:question_id])
    answer = Answer.find(params[:answer_id])
    comment = Comment.find(params[:comment_id])
    comment.update(comment_params)

    if comment.save
      flash[:success] = 'Your Comment was successfully updated!!'
      redirect_to "/questions/#{question.id}"
    else
      flash[:error] = comment.errors.full_messages.to_sentence
      redirect_to "/questions/#{question.id}/answers/#{answer.id}/comments/#{comment.id}/edit"
    end
  end

  def destroy
    question = Question.find(params[:question_id])
    answer = Answer.find(params[:answer_id])
    Comment.destroy(params[:comment_id])
    redirect_to "/questions/#{question.id}"
    flash[:notification] = 'Your Comment was successfully deleted!'
  end

  private 
  
  def comment_params
    params.permit(:content)
  end
end