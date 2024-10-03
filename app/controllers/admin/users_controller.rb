class Admin::UsersController < ApplicationController
    before_action: :authenticate_user!
    before_action: :require_admin

    def index
      @users = User.where(role: :user)
    end

    def new 
        @user = User.new 
    end

    def create
        @user = User.new(user_params)
        @user.password = Devise.friendly_token.first(8)

        if @user.save 
            UserMailer.welcome_email(@user, @user.password).deliver_later
            redirect_to admin_users_path, notice: 'User was successfully create.'
        else
            render :new 
        end

    end

    private 

    def user_params 
        params.require(:user).permit(:email, :role)
    end

    def require_admin
        redirect_to root_path unless current_user.admin?
    end

end