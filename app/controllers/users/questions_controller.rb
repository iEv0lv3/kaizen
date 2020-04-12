class Users::QuestionsController < Users::BaseController
  def new
    @question = Question.new
  end

  def create
    require "pry"; binding.pry
  end
end
