class User < ApplicationRecord
  before_create :skip_confirmation!

  validates_uniqueness_of :email
  validates :email, confirmation: true
  validates :email, confirmation: { case_sensitive: false }
  validates_presence_of :user_name
  validates_uniqueness_of :user_name
  validates :user_name, confirmation: true
  validates :user_name, confirmation: { case_sensitive: false }
  validates :user_name, length: { maximum: 10 }
  validates_presence_of :encrypted_password
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :cohort
  validates :cohort, length: { maximum: 4 }
  validates :cohort, length: { minimum: 4 }
  validates :cohort, numericality: true
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

  def recent_questions
    questions.order(updated_at: :desc).limit(3)
  end

  def upvoted?(resource)
    !resource.votes.find_by(user_id: id).nil?
  end

  def my_medals
    if total_activity >= 15
      'kaizen_award_yellow.png'
    elsif total_activity >= 10
      'kaizen_award_red.png'
    elsif total_activity >= 5
      'kaizen_award_blue.png'
    else
      'kaizen_award_green.png'
    end
  end

  def total_activity
    my_answers + my_questions + my_comments
  end

  def my_answers
    answers.count
  end

  def my_questions
    questions.count
  end

  def my_comments
    comments.count
  end
end
