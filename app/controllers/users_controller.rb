class UsersController < ApplicationController

    before_action :authenticate_user!
    # before_action :require_admin

    def index
        @users = User.where(admin: false)
    end
end