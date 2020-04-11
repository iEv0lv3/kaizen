class TechnicalForumController < ApplicationController
  def index
    @questions = Question.technical_questions
  end
end
