class Users::ProfileController < Users::BaseController
  def show
    @user = current_user
  end
end
