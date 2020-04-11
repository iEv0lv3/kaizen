class Users::ProfileController < Users::BaseController
  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def edit_password
    @user = current_user
  end

  def update
    user = current_user
    if user.update(user_params)
      flash[:notice] = 'Profile information updated successfully!'
      redirect_to "/profile"
    else
      flash[:notice] = user.errors.full_messages.to_sentence
      redirect_back(fallback_location: "/profile")
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    if @user.destroy
      redirect_to root_url, notice: "User deleted."
    end
  end

  private

  def user_params
    params.permit(
      :email,
      :first_name,
      :last_name,
      :cohort,
    )
  end
end
