class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  def require_admin
    if current_user && !current_user.admin?
      redirect_to root_path, alert: 'Access denied.'
    end
  end
  protected
  
  def after_sign_in_path(resource)
      if resource.admin?
          admin_home_path
      else
          root_path 
      end
  end
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :name, :position, :date_of_birth, :sex, :date_of_joining, :id_card])
    devise_parameter_sanitizer.permit(:account_update, keys: [:email, :password, :current_password, :name, :position, :date_of_birth, :sex, :date_of_joining, :id_card])
  end

end
