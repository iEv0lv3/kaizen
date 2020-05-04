# require 'elasticsearch'
# require 'elasticsearch/api'
# require 'elasticsearch/model'
# require 'elasticsearch/transport'
# require 'elasticsearch/rails'
# require 'faraday'
# require 'faraday_middleware'
# require 'faraday_middleware/aws_sigv4'

# client = Elasticsearch::Client.new(host: ENV['AWS_ES'], port: 80) do |faraday|
#   faraday.request :aws_sigv4,
#                   service: 'es',
#                   region: 'us-west-2',
#                   access_key_id: ENV['AWS_ACCESS_KEY'],
#                   secret_access_key: ENV['AWS_SECRET_KEY']
# end

# Elasticsearch::Model.client = client
