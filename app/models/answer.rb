require 'elasticsearch/model'
class Answer < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  settings index: { number_of_shards: 1 } do
    mappings dynamic: false do
      indexes :content, type: :text, analyzer: :english
      indexes :verification, type: :byte
    end
  end

  validates_presence_of :content, :verification
  validates :content, length: { maximum: 200, too_long: '%{count} characters is the maximum allowed' }

  has_many :comments, as: :commentable
  has_many :votes, as: :voteable

  belongs_to :user
  belongs_to :question

  enum verification: %i[unverified verified]

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

Answer.import
