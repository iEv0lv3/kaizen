class SearchController < ApplicationController
  def index
    search_query = Question.search(params[:search]) + Answer.search(params[:search])
    @results = SearchFacade.new(search_query)

    if params[:search].empty?
      flash[:warning] = "You must enter something to search."
      redirect_back(fallback_location: root_path)
    elsif @results.sorted.empty?
      flash[:warning] = 'Improve your query for better results.'
    end
  end
end
