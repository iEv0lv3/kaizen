class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  validates_uniqueness_of :email
  validates_presence_of :encrypted_password
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :cohort
  validates_presence_of :status

  has_many :questions
  has_many :answers

  has_many :comments, as: :commentable

  enum status: %i[
    student
    alumni
  ]

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :omniauthable
end
