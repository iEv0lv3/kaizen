class RegistrationsController < Devise::RegistrationsController
  def create
    status = params[:user][:status].to_i
    params[:user][:status] = status

    super
  end

  private

  def sign_up_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :cohort,
      :status,
      :email,
      :password,
      :password_confirmation
    )
  end
end
