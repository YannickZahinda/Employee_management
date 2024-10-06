class HomeController < ApplicationController
    def index
        @meetings = Meeting.all 
        @sick_leaves = SickLeave.all 
        @attendances = Attendance.all 
        @holy_days = HolyDay.all 
        @reports = Report.all
        @users = User.all
    end
end
