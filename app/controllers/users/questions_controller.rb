class Users::QuestionsController < Users::BaseController
  def new
    @question = Question.new
  end

  def create
    forum = params[:question][:forum].to_i
    params[:question][:forum] = forum

    question = Question.new(question_params)
    question.user_id = current_user.id
    if question.save
      if question.forum == "technical"
        redirect_to '/technical_forum'
        flash[:success] = "Your question was successfully submitted!"
      else
        redirect_to '/professional_forum'
        flash[:success] = "Your question was successfully submitted!"
      end
    else
      redirect_to '/questions/new'
      flash[:error] = question.errors.full_messages.to_sentence
    end
  end


  private

    def question_params
      params.require(:question).permit(:subject, :content, :forum)
    end
end
