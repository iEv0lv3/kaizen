class RegistrationsController < Devise::RegistrationsController
  def create
    user = User.new(sign_up_params)
    if user.save
      sign_in(user, scope: :user)
      flash[:success] = 'Welcome to Kaizen! Account created successfully.'
      redirect_to profile_path
    else
      flash[:warning] = user.errors.full_messages.to_sentence
      redirect_to new_user_registration_path
    end
  end

  private

  def sign_up_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :cohort,
      :status,
      :email,
      :user_name,
      :password,
      :password_confirmation
    )
  end
end
