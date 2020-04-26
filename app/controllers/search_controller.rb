class SearchController < ApplicationController
  def index
    @response = SearchFacade.new(params[:search])

    if params[:search].empty?
      flash[:warning] = 'You must enter something to search.'
      redirect_back(fallback_location: root_path)
    elsif @response.results.empty?
      flash[:warning] = 'No results. Improve your query for better results.'
    end
  end
end
