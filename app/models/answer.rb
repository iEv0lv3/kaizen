class Answer < ApplicationRecord
  validates_presence_of :content

  has_many :comments, as: :commentable

  belongs_to :user
  belongs_to :question
end
