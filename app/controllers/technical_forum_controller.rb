class TechnicalForumController < ApplicationController
  def index
    @questions = Question.technical_questions
  end

  def show
    @question = Question.find(params[:question_id])
  end
end