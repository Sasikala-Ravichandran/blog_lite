class RegistrationsController < Devise::RegistrationsController

  protected 

  def after_sign_up_path_for(resource)
     session.delete(:return_to) || current_user
  end
   
  def after_update_path_for(resource)
    current_user
  end

  private

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :about, :url)
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password, :about, :url)
  end
  
end