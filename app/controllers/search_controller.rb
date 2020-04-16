class SearchController < ApplicationController
  def index
    search_query = Question.search(search_params) + Answer.search(search_params)
    @results = SearchFacade.new(search_query)
    if params[:search].empty?
      flash[:warning] = "You must enter something to search."
      redirect_back(fallback_location: root_path)
    elsif @results.sorted.empty?
      flash[:warning] = 'Improve your query for better results.'
    end
  end

  private

  def search_params
    params.permit(:search)
  end
end
