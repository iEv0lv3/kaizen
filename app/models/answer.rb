class Answer < ApplicationRecord
  validates_presence_of :content
  validates_presence_of :upvotes

  belongs_to :user
  belongs_to :question 
end
