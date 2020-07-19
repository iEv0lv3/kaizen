class SearchFacade
  attr_reader :results,
              :aws_results

  def initialize(query)
    @aws_es = AwsEsService.new
    # @results = search_connection(query)
    @results = aws_search(query)
  end

  private

  def aws_search(query)
    results = @aws_es.search(query)
    if results[:hits][:total][:value] > 0
      results[:hits][:hits].reduce([]) do |result_objects, result|
        model = result[:_index]
        if model == 'questions'
          result_objects << Question.find(result[:_source][:id])
        elsif model == 'answers'
          result_objects << Answer.find(result[:_source][:id])
        end
        result_objects
      end
    else
      []
    end
  end
end
