require 'elasticsearch/model'

class Question < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  settings index: { number_of_shards: 1 } do
    mappings dynamic: false do
      indexes :subject, type: :text, analyzer: :english
      indexes :content, type: :text, analyzer: :english
    end
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

# Question.import
