class Admin::MeetingsController < ApplicationController
    before_action :authenticate_user! 
    before_action :require_admin

    def index 
        @meetings = Meeting.all.includes(:admin)
    end

    def new
        @meeting = Meeting.new 
    end

    def create 
        @meeting = Meeting.new(meeting_params)
        @meeting.admin = current_user

        if @meeting.save 
            redirect_to admin_meetings_path, notice: 'Meeting was successfully created !'
        else 
            render :new, notice: 'Failed to create meeting'
        end 
    end

    private 

    def meeting_params
        params.require(:meeting).permit(:title, :description, :start_time, :end_time)
    end

    def require_admin
        redirect_to root_path, alert: 'Access Denied !' unless current_user.admin?
    end 
end
