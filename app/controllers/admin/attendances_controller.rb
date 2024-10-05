class Admin::AttendancesController < ApplicationController
    before_action :authenticate_user!
    before_action :require_admin

    def index 
      @attendances = Attendance.all 
    end
  
    def new
      @attendance = Attendance.new
    end
  
    def create
      @attendance = Attendance.new(attendance_params)
      if @attendance.save
        redirect_to admin_attendances_path, notice: 'Attendance was successfully recorded.'
      else
        render :new
      end
    end
  
    private
  
    def attendance_params
      params.require(:attendance).permit(:user_id, :date, :status)
    end
  
    def require_admin
      redirect_to root_path, alert: 'Access Denied !' unless current_user.admin?
    end
end