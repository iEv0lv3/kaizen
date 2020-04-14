class Comment < ApplicationRecord
  validates_presence_of :content

  belongs_to :commentable, polymorphic: true
  belongs_to :user 
end
