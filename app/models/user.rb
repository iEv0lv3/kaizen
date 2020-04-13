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
         :confirmable

  devise :omniauthable, omniauth_providers: %i[github stackexchange]

  def award_count
    kapi = KaizenApiService.new(self)
    resp = JSON.parse(kapi.find_awards)
    resp['items'].first['award_count']
  end

  def ordered_questions
    questions.order(updated_at: :desc).limit(3)
  end
end
