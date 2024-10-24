class Users::SessionsController < Devise::SessionsController
  # before_action :store_location, only: :create

  # GET /resource/sign_in
  # def new
  #   super
  # end

  def create 
    # super do |resource|
    #   resource.update(last_sign_in_ip: request.remote_ip)
    #   resource.geocode_last_sign_in_ip
    # end

    super do |resource|
      real_ip = request.env['HTTP_X_FORWARDED_FOR'] || request.env['HTTP_X_REAL_IP'] || request.remote_ip

      Rails.logger.debug "Detected IP $$$$$$$$$$$$$$$$: #{real_ip}"

      resource.update(last_sign_in_ip: real_ip, current_sign_in_ip: real_ip)
      resource.geocode_last_sign_in_ip!
    end


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
