require 'elasticsearch'
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

  private

  def conn
    Faraday.new(url: 'https://search-kaizen-bnz2vfctyqunfmcvryeiw7pfx4.us-west-2.es.amazonaws.com') do |faraday|
      faraday.request :aws_sigv4,
                      service: 'es',
                      region: 'us-west-2',
                      access_key_id: ENV['AWS_ACCESS_KEY'],
                      secret_access_key: ENV['AWS_SECRET_KEY']

    end
  end
end
