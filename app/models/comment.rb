class Comment < ApplicationRecord
  validates_presence_of :content
  validates :content, length: { maximum: 200, too_long: '%{count} characters is the maximum allowed' }

  belongs_to :commentable, polymorphic: true
  belongs_to :user

  has_many :votes, as: :voteable

  def increment_upvotes
    update_column(:upvotes, self.upvotes += 1)
  end
end
