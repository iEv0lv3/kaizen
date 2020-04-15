class Comment < ApplicationRecord
  validates_presence_of :content

  belongs_to :commentable, polymorphic: true
  belongs_to :user

  has_many :votes, as: :voteable

  def increment_upvotes
    update_column(:upvotes, self.upvotes += 1)
  end
end
