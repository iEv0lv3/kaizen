require 'elasticsearch'
require 'elasticsearch/model'
require 'elasticsearch/api'
require 'elasticsearch/rails'
require 'faraday'
require 'faraday_middleware'
require 'faraday_middleware/aws_sigv4'

class AwsEsService
  attr_reader :elasticsearch

  def initialize
    @elasticsearch = conn
  end

  def api_get(endpoint)
    response = @elasticsearch.get endpoint.to_s
    JSON.parse(response.body, symbolize_names: true)
  end

  def api_put(endpoint, body_json)
    response = @elasticsearch.put endpoint.to_s do |req|
      req.headers[:content_type] = 'application/json'
      req.body = body_json
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def search(query)
    response = @elasticsearch.get "/_search?q=#{query}"
    JSON.parse(response.body, symbolize_names: true)
  end

  def api_search(query)
    response = @elasticsearch.post '/_search' do |req|
      req.headers[:content_type] = 'application/json'
      req.body = AwsSearch.new(query).json_build
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def api_create_doc(class_name, id, model_json)
    response = @elasticsearch.put "/#{class_name}/_doc/#{id}" do |req|
      req.headers[:content_type] = 'application/json'
      req.body = model_json
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def api_delete_doc(class_name, id)
    response = @elasticsearch.delete "/#{class_name}/_doc/#{id}"
    JSON.parse(response.body, symbolize_names: true)
  end

  def api_create_index(class_name, index_json)
    response = @elasticsearch.put "/#{class_name}" do |req|
      req.headers[:content_type] = 'application/json'
      req.body = index_json
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def api_delete_index(index)
    response = @elasticsearch.delete "/#{index}"
    JSON.parse(response.body, symbolize_names: true)
  end

  def api_delete_indexes
    response = @elasticsearch.delete '/_all'
    JSON.parse(response.body, symbolize_names: true)
  end

  private

  def conn
    Elasticsearch::Model.client = Faraday.new(url: ENV['AWS_ES']) do |faraday|
      faraday.request :aws_sigv4,
                      service: 'es',
                      region: 'us-west-2',
                      access_key_id: ENV['AWS_ACCESS_KEY'],
                      secret_access_key: ENV['AWS_SECRET_KEY']
    end
  end
end
