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
      puts attendance_params.inspect
      if @attendance.save
        redirect_to admin_attendances_path, notice: 'Attendance was successfully recorded.'
      else
        render :new
      end
    end
  
    private
  
    def attendance_params
      params.require(:attendance).permit(:user_id, :status, :date)
    end

    # def attendance_params
    #   # This will allow :user_id and :status, and convert the date into a Date object
    #   params.require(:attendance).permit(:user_id, :status).merge(date: params[:attendance][:date].to_d)
    # end
    

  
    def require_admin
      redirect_to root_path, alert: 'Access Denied !' unless current_user.admin?
    end
end