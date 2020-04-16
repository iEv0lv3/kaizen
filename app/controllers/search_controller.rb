class SearchController < ApplicationController
  def index
    search_query = Question.search(params[:search]) + Answer.search(params[:search])

    @results = SearchFacade.new(search_query)
  end

  private

  def search_params
    params.permit(:search)
  end
end
