class Admin::SickLeavesController < ApplicationController
    before_action :authenticate_user!
    before_action :require_admin

    def index 
    @sick_leaves = SickLeave.all
    end

    def approve 
        @sick_leave = SickLeave.find(params[:id])
        @sick_leave.update(status: :approved)
        redirect_to admin_sick_leaves_path, notice: 'Sick leave was approved.'
    end

    def approve 
        @sick_leave = SickLeave.find(params[:id])
        @sick_leave.update(status: :rejected)
        redirect_to admin_sick_leaves_path, notice: 'Sick leave was rejected'
    end

    private 

    def require_admin
        redirect_to root_path, alert: 'Access Denied !' unless current_user.admin?
    end
end