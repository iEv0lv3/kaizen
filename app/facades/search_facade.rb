class SearchFacade
  attr_reader :sorted

  def initialize(search_results)
    @sorted = sort_results(search_results)
  end

  def sort_results(search_results)
    search_results.sort_by(&:upvotes).reverse
  end
end
