class Users::CallbacksController < Devise::OmniauthCallbacksController
  def github
    @user = User.from_omniauth(request.env["omniauth.auth"])
    redirect_to profile_path, notice: 'Connected to GitHub!'
  end
end
