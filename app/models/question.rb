class Question < ApplicationRecord
  validates_presence_of :subject
  validates_presence_of :content
  validates_presence_of :upvotes
  validates_presence_of :forum

  enum forum: ["technical", "professional"]

  has_many :comments, as: :commentable
  has_many :answers

  belongs_to :user

  def self.technical_questions
    select("questions.*").where(forum: 0).order(created_at: :DESC)
  end

  def self.professional_questions
    select("questions.*").where(forum: 1).order(created_at: :DESC)
  end
end
