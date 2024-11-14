class Users::SessionsController < Devise::SessionsController
  # before_action :store_location, only: :create

  # GET /resource/sign_in
  # def new
  #   super
  # end

  def create 

    super do |resource|
      real_ip = if Rails.env.development?
                  "41.186.175.66"
      else
        request.env['HTTP_X_FORWARDED_FOR']&.split(',')&.first || 
        request.env['HTTP_X_REAL_IP'] || request.remote_ip
      end 

      Rails.logger.debug "Detected IP $$$$$$$$$$$$$$$$: #{real_ip}"

      resource.update(last_sign_in_ip: real_ip, current_sign_in_ip: real_ip)
      resource.geocode_last_sign_in_ip
    end


  end

  # def create
  #   super do |resource|
  #     real_ip = if Rails.env.production?
  #                 # In production, try multiple headers
  #                 request.env['HTTP_X_FORWARDED_FOR']&.split(',')&.first ||
  #                 request.env['HTTP_X_REAL_IP'] ||
  #                 request.remote_ip
  #               else
  #                 # In development, use a test IP or the actual remote IP
  #                 ENV['TEST_IP'] || request.remote_ip
  #               end

  #     Rails.logger.info "Detected IP ##################: #{real_ip}"
      
  #     # Clear any cached results for this IP
  #     # Geocoder.cache.expire(real_ip) if Geocoder.cache
      
  #     resource.update(
  #       current_sign_in_ip: real_ip,
  #       last_sign_in_ip: resource.current_sign_in_ip
  #     )
  #   end
  # end

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
