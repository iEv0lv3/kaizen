class Users::QuestionsController < Users::BaseController
  def new
    @question = Question.new
  end

  def create
    question = Question.new(question_params)
    question.user_id = current_user.id

    if question.save
      if question.forum == 'technical'
        redirect_to '/technical_forum'
        flash[:success] = 'Your question was successfully submitted!'
      elsif question.forum == 'professional'
        redirect_to '/professional_forum'
        flash[:success] = 'Your question was successfully submitted!'
      end
    else
      redirect_to '/questions/new'
      flash[:warning] = question.errors.full_messages.to_sentence
    end
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    forum = params[:question][:forum].to_i
    params[:question][:forum] = forum

    question = Question.find(params[:id])
    question.update(question_params)
    if question.save
      flash[:success] = 'Your question was successfully updated!'
      redirect_to "/questions/#{question.id}"
    else
      flash[:error] = question.errors.full_messages.to_sentence
      redirect_to "/questions/#{question.id}/edit"
    end
  end

  def destroy
    question = Question.find(params[:id])
    forum = question.forum
    Question.destroy(params[:id])
    redirect_to "/#{forum}_forum"
    flash[:success] = 'Your question was successfully deleted.'
  end

  def upvote
    question = Question.find(params[:id].to_i)
    vote = question.votes.new
    vote.user_id = current_user.id
    vote.save

    question.update_column(:upvotes, question.upvotes += 1)
    redirect_to "/questions/#{question.id}"
  end

  private

  def question_params
    params.require(:question).permit(:subject, :content, :forum)
  end
end
