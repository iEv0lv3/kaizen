class Question < ApplicationRecord
  validates_presence_of :subject
  validates_presence_of :content
  validates_presence_of :upvotes
  validates_presence_of :type

  has_many :comments, as: :commentable
  has_many :answers

  belongs_to :user
end
