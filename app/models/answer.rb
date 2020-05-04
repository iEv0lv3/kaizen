require 'elasticsearch/model'
require 'sidekiq'
require 'redis'

class Answer < ApplicationRecord
  include Elasticsearch::Model
  # include Elasticsearch::Model::Callbacks

  # settings index: { number_of_shards: 1 } do
  #   mappings dynamic: false do
  #     indexes :content, type: :text, analyzer: :english
  #     indexes :verification, type: :text, analyzer: :english
  #   end
  # end

  after_save do |answer|
    doc_json = answer.create_doc
    IndexerWorker.perform_async('create', 'answers', answer.id.to_s, doc_json)
  end

  before_destroy do |answer|
    doc_json = answer.create_doc
    IndexerWorker.perform_async('destroy', 'answers', answer.id.to_s, doc_json)
  end

  validates_presence_of :content, :verification
  validates :content, length: { maximum: 200, too_long: '%{count} characters is the maximum allowed' }

  has_many :comments, as: :commentable
  has_many :votes, as: :voteable

  belongs_to :user
  belongs_to :question

  enum verification: %i[unverified verified]

  def self.create_index
    Jbuilder.encode do |json|
      json.mappings do
        json.properties do
          json.id do
            json.type 'keyword'
          end
          json.content do
            json.type 'text'
            json.analyzer 'english'
          end
        end
      end
    end
  end

  def create_doc
    Jbuilder.encode do |json|
      json.id id.to_s
      json.content content
    end
  end

  def increment_upvotes
    update_column(:upvotes, self.upvotes += 1)
  end

  def verify_answer
    self.verification = 1
  end

  def verification_status
    verified? ? 'green-check-small.png' : ''
  end
end
