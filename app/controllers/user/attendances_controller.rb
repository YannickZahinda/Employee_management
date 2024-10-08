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
      if @attendance.save
        redirect_to user_attendances_path, notice: 'Attendance was successfully recorded.'
      else
        render :new
      end
    end
  
    private
  
    def attendance_params
      params.require(:attendance).permit(:status, :date)
    end
  end
  