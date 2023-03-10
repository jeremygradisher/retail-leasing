class RegistrationsController < Devise::RegistrationsController

  private

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :email, :role, :is_admin, :password, :password_confirmation, :current_password, user_avatars_attributes: [:id, :user_id, :avatar])
  end
end