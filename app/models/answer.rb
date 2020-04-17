class Answer < ApplicationRecord
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

  def self.search(search_params)
    where('content ILIKE :search', search: "%#{search_params}%").limit(5)
  end

  def verify_answer
    self.verification = 1
  end

  def verification_status
    self.verified? ? 'green-check-small.png' : ''
  end
end
