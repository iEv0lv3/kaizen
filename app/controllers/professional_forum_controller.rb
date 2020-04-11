class ProfessionalForumController < ApplicationController
  def index
    @questions = Question.professional_questions
  end
end
