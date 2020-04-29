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
    @es2 = conn2
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
    # Below could be the index for the sample data
    # /kibana_sample_data_flights/_search
    response = @elasticsearch.post '/kibana_sample_data_flights/_search' do |req|
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

  def conn2
    Elasticsearch::Client.new(url: ENV['AWS_ES']) do |f|
      f.request :aws_sigv4,
                service: 'es',
                region: 'us-west-2',
                access_key_id: ENV['AWS_ACCESS_KEY'],
                secret_access_key: ENV['AWS_SECRET_KEY']
    end
  end
end

  #  :mappings=>
  #   {:properties=>
  #     {:AvgTicketPrice=>{:type=>"float"},
  #      :Cancelled=>{:type=>"boolean"},
  #      :Carrier=>{:type=>"keyword"},
  #      :Dest=>{:type=>"keyword"},
  #      :DestAirportID=>{:type=>"keyword"},
  #      :DestCityName=>{:type=>"keyword"},
  #      :DestCountry=>{:type=>"keyword"},
  #      :DestLocation=>{:type=>"geo_point"},
  #      :DestRegion=>{:type=>"keyword"},
  #      :DestWeather=>{:type=>"keyword"},
  #      :DistanceKilometers=>{:type=>"float"},
  #      :DistanceMiles=>{:type=>"float"},
  #      :FlightDelay=>{:type=>"boolean"},
  #      :FlightDelayMin=>{:type=>"integer"},
  #      :FlightDelayType=>{:type=>"keyword"},
  #      :FlightNum=>{:type=>"keyword"},
  #      :FlightTimeHour=>{:type=>"keyword"},
  #      :FlightTimeMin=>{:type=>"float"},
  #      :Origin=>{:type=>"keyword"},
  #      :OriginAirportID=>{:type=>"keyword"},
  #      :OriginCityName=>{:type=>"keyword"},
  #      :OriginCountry=>{:type=>"keyword"},
  #      :OriginLocation=>{:type=>"geo_point"},
  #      :OriginRegion=>{:type=>"keyword"},
  #      :OriginWeather=>{:type=>"keyword"},
  #      :dayOfWeek=>{:type=>"integer"},
  #      :timestamp=>{:type=>"date"}}},
