class User::AttendancesController < ApplicationController
    before_action :authenticate_user!
  
    def index
      @attendances = current_user.attendances
    end
  
    def new
      @attendance = Attendance.new
    end
  
    def create
      @attendance = current_user.attendances.new(attendance_params)
      @attendance.date = Time.current.in_time_zone('Africa/Harare')
      if @attendance.save
        redirect_to user_attendances_path, notice: 'Attendance was successfully recorded.'
      else
        render :new
      end
    end
  
    private
  
    def attendance_params
      params.require(:attendance).permit(:status, :date, :worked_hours)
    end
  end
  