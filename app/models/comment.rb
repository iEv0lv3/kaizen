class Comment < ApplicationRecord
  validates_presence_of :content
  validates_presence_of :upvotes

  belongs_to :commentable, polymorphic: true 
end
