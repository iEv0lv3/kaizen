class Answer < ApplicationRecord
  validates_presence_of :content

  has_many :comments, as: :commentable
  has_many :votes, as: :voteable

  belongs_to :user
  belongs_to :question
end
