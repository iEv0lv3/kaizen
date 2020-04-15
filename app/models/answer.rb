class Answer < ApplicationRecord
  validates_presence_of :content
  validates :content, length: { maximum: 200, too_long: "%{count} characters is the maximum allowed" }

  has_many :comments, as: :commentable

  belongs_to :user
  belongs_to :question
end
