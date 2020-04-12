class AnswersController < ApplicationController

    def show
        @answer = Answer.find(params[:id])
    end

    def new 
        @quesiton = Question.find(params[:id])
    end
end