require 'sidekiq'
require 'redis'

class IndexerWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'default', retry: false

  def initialize
    @client = AwsEsService.new
  end

  def perform(operation, index, id, model_json)
    if operation == 'delete'
      @client.api_delete_doc(index, id)
    else
      @client.api_create_doc(index, id, model_json)
    end
  end
end
