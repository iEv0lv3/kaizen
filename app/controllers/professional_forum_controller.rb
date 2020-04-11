class ProfessionalForumController < ApplicationController
  def index
    @questions = Question.professional_questions
  end

  def show
    @question = Question.find(params[:question_id])
  end
end
