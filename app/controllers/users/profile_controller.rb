class Users::ProfileController < Users::BaseController
  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    user = current_user
    if user.update(user_params)
      if params[:password]
        flash[:notice] = 'Successfully updated password.'
      else
        flash[:notice] = 'Profile information updated successfully!'
      end
      redirect_to "/profile"
    else
      flash[:notice] = user.errors.full_messages.to_sentence
      redirect_back(fallback_location: "/profile")
    end
  end

  private 

  def user_params
  params.permit(
    :email,
    :first_name,
    :last_name,
    :cohort,
    :password,
    :password_confirmation
  )
  end
end
