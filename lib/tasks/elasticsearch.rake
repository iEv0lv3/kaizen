namespace :aws do
  desc 'Create Indexes'

  def log(msg)
    puts msg
    Rails.logger.info(msg)
  end

  task create_index: :environment do
    log('Starting AWS Elasticsearch Index Creation...')

    log('Creating AWS Elasticsearch service...')
    aws_es = AwsEsService.new
    q_index = Question.create_index
    a_index = Answer.create_index

    log('Creating Questions Index...')
    aws_es.api_create_index('questions', q_index)
    JSON.parse(response.body, symbolize_names: true)

    log('Creating Answers Index...')
    aws_es.api_create_index('answers', a_index)
    JSON.parse(response.body, symbolize_names: true)

    log('Indexes created.')
  end
end
