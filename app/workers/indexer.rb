require 'sidekiq'

class Indexer
  include Sidekiq::Worker
  sidekiq_options queue: 'default', retry: false

  def initialize
    @logger = Sidekiq.logger.level == Logger::DEBUG ? Sidekiq.logger : nil
    @client = AwsEsApiService.new.elasticsearch
  end

  def perform(operation, index, id, model_json)
    @logger.debug [operation, "ID: #{index}"]

    if operation == 'delete'
      @client.delete index: index, id: id
    else
      @client.index  index: index, id: id, body: model_json
    end
  end
end
