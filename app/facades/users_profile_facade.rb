class UsersProfileFacade
  attr_reader :user,
              :gh_token,
              :so_token,
              :activity,
              :kaizen_medals,
              :so_awards,
              :recent_questions

  def initialize(user)
    @user = User.find_by(id: user.id)
    @gh_token = @user.gh_token
    @so_token = @user.so_token
    @kaizen_medals = @user.my_medals
    @so_awards = so_awards_check
    @recent_questions = @user.recent_questions
  end

  def so_awards_check
    @so_token.nil? ? 0 : @user.award_count
  end
end
