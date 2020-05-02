require 'sidekiq'

class Indexer
  include Sidekiq::Worker
  sidekiq_options queue: 'default', retry: false

  def initialize
    @logger = Sidekiq.logger.level == Logger::DEBUG ? Sidekiq.logger : nil
    @client = AwsEsService.new
  end

  def perform(operation, index, id, model_json)
    @logger.debug [operation, "ID: #{index}"]

    if operation == 'delete'
      @client.api_delete_doc(index, id)
    else
      @client.api_create_doc(index, id, model_json)
    end
  end
end
