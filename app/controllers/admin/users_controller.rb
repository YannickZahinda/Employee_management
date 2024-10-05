class Admin::UsersController < AdminController
    before_action :authenticate_user!
    before_action :require_admin

    def index
        @users = User.where(admin: false)
    end

    def user_reports
        @user = User.find(params[:id])
        @reports = @user.reports
    end

    def new 
        @user = User.new 
    end

    def create
        @user = User.new(user_params)
        @user.password = Devise.friendly_token.first(8) if @user.password.blank?

        if @user.save 
            UserMailer.welcome_email(@user, @user.password).deliver_later
            redirect_to admin_users_path, notice: 'User was successfully create.'
        else
            render :new 
        end

    end

    private 

    def user_params 
        params.require(:user).permit(:email, :admin, :password)
    end

    def require_admin
        redirect_to root_path, alert: 'Access denied.' unless current_user.admin?
    end

end