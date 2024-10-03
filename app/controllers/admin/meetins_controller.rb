class Admin::MeetingsController < ApplicationController
    before_action :authenticate_user 
    before_action :require_admin

    def new
        @meetings = Meeting.new 
    end

    def create 
        @meeting = Meeting.new(meeting_params)
        @meeting.admin = current_user

        if @meeting.save 
            redirect_to meeting_path, notice: 'Meeting was successfully created !'
        else 
            render :new 
        end 
    end

    private 

    def meeting_params
        params.require(:meetins).permit(:title, :description, :start_time, :end_time)
    end

    def require_admin
        redirect_to root_path unless current_user.admin?
    end 
end
