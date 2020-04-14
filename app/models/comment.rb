class Comment < ApplicationRecord
  validates_presence_of :content

  belongs_to :commentable, polymorphic: true
  belongs_to :user

  has_many :votes, as: :voteable
end
