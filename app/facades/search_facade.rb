class SearchFacade
  attr_reader :results

  def initialize(query)
    @results = search_connection(query)
  end

  private

  def search_connection(query)
    Elasticsearch::Model.search(query, [Question, Answer]).records.to_a
  end
end
