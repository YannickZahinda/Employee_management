class Admin::SickLeavesController < ApplicationController
    before_action :authenticate_user!
    before_action :require_admin

    def index 
    @sick_leaves = SickLeave.all
    end

    def approve 
        @sick_leave = SickLeave.find(params[:id])
        @sick_leave.update(status: :approved)
        redirect_to admin_sick_leaves_path, notice: 'Votre congé a été approuvé'
    end

    def reject 
        @sick_leave = SickLeave.find(params[:id])
        @sick_leave.update(status: :rejected)
        redirect_to admin_sick_leaves_path, notice: 'Votre congé à été refusé'
    end

    private 

    # def require_admin
    #     redirect_to root_path, alert: 'Access Denied !' unless current_user.admin?
    # end

    def require_admin
        if current_user && !current_user.admin?
          redirect_to root_path, alert: 'Access denied.'
        end
    end
end