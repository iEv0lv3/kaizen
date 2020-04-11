class Users::CallbacksController < Devise::OmniauthCallbacksController
  def github
    gh_auth = request.env["omniauth.auth"]

    current_user.update(
      gh_token: gh_auth['credentials']['token'],
      gh_login: gh_auth['info']['nickname']
    )

    redirect_to profile_path, notice: 'Connected to GitHub!'
  end
end
