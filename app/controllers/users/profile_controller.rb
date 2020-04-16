class Users::ProfileController < Users::BaseController
  def show
    @profile = UsersProfileFacade.new(current_user)
  end

  def edit
    @profile = UsersProfileFacade.new(current_user)
  end

  def update
    user = current_user
    if user.update(user_params)
      flash[:notice] = 'Profile information updated successfully!'
      redirect_to '/profile'
    else
      flash[:notice] = user.errors.full_messages.to_sentence
      redirect_back(fallback_location: '/profile')
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    redirect_to root_url, notice: 'User deleted.' if @user.destroy
  end

  private

  def user_params
    params.permit(
      :email,
      :user_name,
      :first_name,
      :last_name,
      :cohort,
      :status,
      :user_name
    )
  end
end
