class SickLeavesController < ApplicationController
    before_action :authenticate_user, only: [:new, :create]

    def index 
        @sick_leaves = current_user.sick_leaves
        respond_to do |format|
            format.html # This will render index.html.erb
            format.json { render json: @sick_leaves }
        end
    end

    def new 
        @sick_leaves = current_user.sick_leaves.build 
    end 

    def create 
        @sick_leave = current_user.sick_leaves.build(sick_leave_params)
        if @sick_leave.save 
            redirect_to sick_leaves_path, notice: 'Sick leave request was created successfully'
        else 
            render :new 
        end 
    end 

    private 

    def sick_leave_params
        params.require(:sick_leaves).permit(:start_date, :end_date, :reason)
    end
    
    def authenticate_user
        if current_user.admin?
            redirect_to root_path, alert: 'Administrateur ne peux demander un congé parler à ingenieur'
        end
    end
end
