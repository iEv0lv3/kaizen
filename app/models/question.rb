require 'elasticsearch/model'
require 'sidekiq'
require 'redis'

class Question < ApplicationRecord
  include Elasticsearch::Model
  # include Elasticsearch::Model::Callbacks

  # settings index: { number_of_shards: 1 } do
  #   mappings dynamic: false do
  #     indexes :subject, type: :text, analyzer: :english
  #     indexes :content, type: :text, analyzer: :english
  #   end
  # end

  after_save do |question|
    doc_json = question.create_doc
    IndexerWorker.perform_async('create', 'questions', question.id.to_s, doc_json)
  end

  before_destroy do |question|
    doc_json = question.create_doc
    IndexerWorker.perform_async('destroy', 'questions', question.id.to_s, doc_json)
  end

  validates_presence_of :subject
  validates_presence_of :content
  validates :content, length: { maximum: 200, too_long: '%{count} characters is the maximum allowed' }
  validates :subject, length: { maximum: 90, too_long: '%{count} characters is the maximum allowed' }
  validates :forum, presence: true

  enum forum: %i[technical professional]

  has_many :comments, as: :commentable
  has_many :votes, as: :voteable
  has_many :answers, dependent: :destroy

  belongs_to :user

  def self.create_index
    Jbuilder.encode do |json|
      json.mappings do
        json.properties do
          json.id do
            json.type 'keyword'
          end
          json.subject do
            json.type 'text'
            json.analyzer 'english'
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
      json.subject subject
      json.content content
    end
  end

  def self.technical_questions
    select('questions.*').where(forum: 0).order(created_at: :DESC)
  end

  def self.professional_questions
    select('questions.*').where(forum: 1).order(created_at: :DESC)
  end

  def increment_upvotes
    update_column(:upvotes, self.upvotes += 1)
  end

  def has_verified_answer?
    !answers.find_by(verification: 'verified').nil?
  end
end
