class HomeController < ApplicationController
    def index
        @meetings = Meeting.all 
        @sick_leaves = SickLeave.all 
        @attendances = Attendance.all 
        @holy_days = HolyDay.all 
        @reports = Report.all
        @users = User.all
        @total_reports = Report.count
        @total_meetings = Meeting.count
        @total_sick_leaves = SickLeave.count 
        @total_presents_employees = Attendance.where(status: 'present').count
        @total_absents_employees = Attendance.where(status: 'absent').count
    end
end
