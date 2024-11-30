class Users::SessionsController < Devise::SessionsController
  # before_action :store_location, only: :create

  # GET /resource/sign_in
  # def new
  #   super
  # end

  def create 
    Rails.logger.debug "SessionsController: Before Devise authentication"

    super do |resource|
      real_ip = if Rails.env.development?
                  "41.186.175.66"
      else
        request.env['HTTP_X_FORWARDED_FOR']&.split(',')&.first || 
        request.env['HTTP_X_REAL_IP'] || request.remote_ip
      end 

      Rails.logger.debug "Detected IP $$$$$$$$$$$$$$$$: #{real_ip}"

      resource.update(last_sign_in_ip: real_ip, current_sign_in_ip: real_ip)
      # resource.geocode_last_sign_in_ip

      Rails.logger.debug "SessionsController: Authentication successful for user #{resource.email}"
      Rails.logger.debug "SessionsController: Session details: #{session.inspect}"
      Rails.logger.debug "SessionsController: Warden details: #{warden.inspect}"
    end

    Rails.logger.debug "SessionsController: After super call"

    


  end

  def after_sign_in_path_for(resource)
    # Specify your dashboard path here
    root_path # or whatever your dashboard route is named
  end


  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
