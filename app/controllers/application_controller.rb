class ApplicationController < ActionController::Base
    before_action :authenticate_user!
    before_action :authenticate_user!
    
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

end
