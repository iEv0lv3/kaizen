require 'rails_helper'

RSpec.describe 'AWS Elasticsearch', :vcr, elasticsearch: true do
  before :each do
    @aws = AwsEsService.new
  end

  it 'cluster stats' do
    cluster_stats = @aws.api_get('/_cluster/stats')

    expect(cluster_stats[:cluster_name].class).to eq(String)
    expect(cluster_stats[:cluster_name]).to eq('218497580724:kaizen')
    expect(cluster_stats[:indices][:count].class).to eq(Integer)
    expect(cluster_stats[:nodes][:count][:total].class).to eq(Integer)
  end
end
