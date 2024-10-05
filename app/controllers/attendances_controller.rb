class AttendancesController < ApplicationController
    before_action :authenticate_user!

    def index
      # @attendances = current_user.attendances
      @attendances = Attendance.all 
    end

    def all_attendance 
      @attendances = Attendance.all 
    end
end
