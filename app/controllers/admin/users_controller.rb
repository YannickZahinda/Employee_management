class Admin::UsersController < AdminController
    require 'rqrcode'
    before_action :authenticate_user!
    before_action :require_admin

    def index
        @users = User.where(admin: false)
        @performance_analyses = {}
        @users.each do |user|
            @performance_analyses[user.id] = user.performance_analysis
        end
    end

    def user_reports
        @user = User.find(params[:id])
        @reports = @user.reports
    end

    def new 
        @user = User.new 
    end

    def show 
        @user = User.find(params[:id])
    end

    def create
        # Rails.logger.debug("User Params: #{user_params.inspect}")
        @user = User.new(user_params)
        @user.password = Devise.friendly_token.first(8) if @user.password.blank?

        if @user.save 
            UserMailer.welcome_email(@user, @user.password).deliver_later
            generate_qrcode(@user)
            sign_in(@user)
            redirect_to admin_users_path, notice: 'User was successfully create.'
        else
            render :new 
        end

    end

    private 

    def user_params
        params.require(:user).permit(
          :email, 
          :name, 
          :position, 
          :date_of_birth, 
          :sex, 
          :date_of_joining, 
          :id_card, 
          :admin, 
          :password, 
          :password_confirmation,
          :qr_code,
          :avatar,
          :last_known_location
        )
    end
      
      

    def require_admin
        redirect_to root_path, alert: 'Access denied.' unless current_user.admin?
    end

    def generate_qrcode(user)
        
        host = Rails.application.routes.default_url_options[:host] || 'localhost:3000'
    
        url = user_attendances_url(host: host)
       
        qr_code = RQRCode::QRCode.new(url)

        
        png = qr_code.as_png(
          bit_depth: 1,
          border_modules: 4,
          color_mode: ChunkyPNG::COLOR_GRAYSCALE,
          color: 'black',
          fill: 'white',
          module_px_size: 6,
          size: 120
        )
        user.qr_code.attach(io: StringIO.new(png.to_s), filename: "#{user.id}_qrcode.png", content_type: 'image/png')
    end
end
