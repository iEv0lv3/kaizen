require 'elasticsearch'
require 'elasticsearch/api'
require 'elasticsearch/rails'
require 'faraday'
require 'faraday_middleware'
require 'faraday_middleware/aws_sigv4'

class AwsEsService
  include Elasticsearch::API

  attr_reader :elasticsearch, :es2

  def initialize
    @elasticsearch = conn
  end

  def api_get(endpoint)
    response = @elasticsearch.get endpoint.to_s
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