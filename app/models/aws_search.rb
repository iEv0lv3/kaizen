require 'jbuilder'

class AwsSearch
  attr_reader :json_build

  def initialize(query)
    @json_build = search(query)
  end

  def search(query)
    Jbuilder.encode do |json|
      json.size 20
      json.query do
        json.multi_match do
          json.query query
          json.fields ['subject', 'content']
        end
      end
    end
  end
end
