require 'elasticsearch'
require 'elasticsearch/model'
require 'elasticsearch/api'
require 'elasticsearch/rails'
require 'faraday'
require 'faraday_middleware'
require 'faraday_middleware/aws_sigv4'

class AwsEsApiService
  include Elasticsearch::API

  attr_reader :elasticsearch

  def initialize
    @elasticsearch = conn
  end

  private

  def conn
    Elasticsearch::Model.client = Elasticsearch::Client.new(host: ENV['AWS_ES'], port: 443) do |faraday|
      faraday.request :aws_sigv4,
                      service: 'es',
                      region: 'us-west-2',
                      access_key_id: ENV['AWS_ACCESS_KEY'],
                      secret_access_key: ENV['AWS_SECRET_KEY']
    end
  end
end
