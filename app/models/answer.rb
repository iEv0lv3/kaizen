class Answer < ApplicationRecord
  validates_presence_of :content
  validates :content, length: { maximum: 200, too_long: "%{count} characters is the maximum allowed" }

  has_many :comments, as: :commentable
  has_many :votes, as: :voteable

  belongs_to :user
  belongs_to :question

  def increment_upvotes
    update_column(:upvotes, self.upvotes += 1)
  end
end
