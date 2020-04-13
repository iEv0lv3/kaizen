class QuestionsController < ApplicationController
  def show
    @question = Question.find(params[:id])
    @answers = @question.answers
  end
end
