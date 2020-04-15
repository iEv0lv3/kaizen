class User < ApplicationRecord
  before_create :skip_confirmation!
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

  has_many :comments
  has_many :votes

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

    if resp['items'].empty?
      0
    else
      resp['items'].first['award_count']
    end
  end

  def ordered_questions
    questions.order(updated_at: :desc).limit(3)
  end

  def upvoted?(resource)
    !resource.votes.find_by(user_id: id).nil?
  end
end
